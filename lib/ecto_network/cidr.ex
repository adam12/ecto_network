defmodule EctoNetwork.CIDR do
  @moduledoc ~S"""
  Support for using Ecto with :cidr fields
  """

  @behaviour Ecto.Type

  def type, do: :cidr

  @doc "Handle casting to Postgrex.CIDR"
  def cast(%Postgrex.CIDR{}=address), do: {:ok, address}
  def cast(address) when is_binary(address) do
    [address, netmask] = address |> String.split("/")

    {:ok, parsed_address} =
      address
      |> String.to_char_list()
      |> :inet.parse_address

    netmask = netmask |> String.to_integer()

    {:ok, %Postgrex.CIDR{address: parsed_address, netmask: netmask}}
  end
  def cast(_), do: :error

  @doc "Load from the native Ecto representation"
  def load(%Postgrex.CIDR{}=address), do: {:ok, address}
  def load(_), do: :error

  @doc "Convert to the native Ecto representation"
  def dump(%Postgrex.CIDR{}=address), do: {:ok, address}
  def dump(_), do: :error

  @doc "Convert from native Ecto representation to a binary"
  def decode(%Postgrex.CIDR{address: address, netmask: netmask}) do
    case :inet.ntoa(address) do
      {:error, _einval} -> :error
      formatted_address -> List.to_string(formatted_address) <> "/#{netmask}"
    end
  end
end

defimpl String.Chars, for: Postgrex.CIDR do
  def to_string(%Postgrex.CIDR{}=address), do: EctoNetwork.CIDR.decode(address)
end

if Code.ensure_loaded?(Phoenix.HTML) do
  defimpl Phoenix.HTML.Safe, for: Postgrex.CIDR do
    def to_iodata(%Postgrex.CIDR{}=address), do: EctoNetwork.CIDR.decode(address)
  end
end
