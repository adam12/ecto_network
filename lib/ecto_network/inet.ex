defmodule EctoNetwork.INET do
  @moduledoc ~S"""
  Support for using Ecto with :inet fields
  """

  @behaviour Ecto.Type

  def type, do: :inet

  @doc "Handle casting to Postgrex.INET"
  def cast(%Postgrex.INET{} = address), do: {:ok, address}

  def cast(address) when is_tuple(address),
    do: cast(%Postgrex.INET{address: address, netmask: address_netmask(address)})

  def cast(address) when is_binary(address) do
    {address, netmask} =
      case String.split(address, "/") do
        [address] -> {address, nil}
        [address, netmask] -> {address, netmask}
        [address, netmask | _] -> {address, netmask}
      end

    address
    |> String.to_charlist()
    |> :inet.parse_address()
    |> case do
      {:ok, address} ->
        netmask =
          if netmask do
            String.to_integer(netmask)
          else
            address_netmask(address)
          end

        {:ok, %Postgrex.INET{address: address, netmask: netmask}}

      {:error, _} ->
        :error
    end
  end

  def cast(_), do: :error

  @doc "Load from the native Ecto representation"
  def load(%Postgrex.INET{} = inet) do
    inet =
      cond do
        address_netmask(inet.address, inet.netmask) -> inet
        address_netmask(inet.address) -> %{inet | netmask: address_netmask(inet.address)}
        true -> %{inet | netmask: nil}
      end

    {:ok, inet}
  end

  def load(_), do: :error

  @doc "Convert to the native Ecto representation"
  def dump(%Postgrex.INET{} = inet) do
    inet =
      if inet.netmask do
        inet
      else
        %{inet | netmask: address_netmask(inet.address)}
      end

    {:ok, inet}
  end

  def dump(_), do: :error

  @doc "Convert from native Ecto representation to a binary"
  def decode(%Postgrex.INET{address: address, netmask: netmask}) do
    netmask = address_netmask(address, netmask)

    address
    |> :inet.ntoa()
    |> case do
      {:error, _} ->
        :error

      address ->
        address = List.to_string(address)
        if netmask, do: "#{address}/#{netmask}", else: address
    end
  end

  defp address_netmask(address) do
    if(tuple_size(address) == 4, do: 32, else: 128)
  end

  defp address_netmask(address, netmask) do
    cond do
      tuple_size(address) == 4 && netmask == 32 -> nil
      tuple_size(address) == 8 && netmask == 128 -> nil
      true -> netmask
    end
  end
end

defimpl String.Chars, for: Postgrex.INET do
  def to_string(%Postgrex.INET{} = address), do: EctoNetwork.INET.decode(address)
end

if Code.ensure_loaded?(Phoenix.HTML) do
  defimpl Phoenix.HTML.Safe, for: Postgrex.INET do
    def to_iodata(%Postgrex.INET{} = address), do: EctoNetwork.INET.decode(address)
  end
end
