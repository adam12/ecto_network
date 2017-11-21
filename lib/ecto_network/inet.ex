defmodule EctoNetwork.INET do
  @moduledoc ~S"""
  Support for using Ecto with :inet fields
  """

  @behaviour Ecto.Type

  def type, do: :inet

  @doc "Handle casting to Postgrex.INET"
  def cast(address) do
    address
    |> case do
      %Postgrex.INET{}=address -> {:ok, address}
      address when is_tuple(address) -> cast(%Postgrex.INET{address: address})
      address when is_binary(address) -> parse_address(address) |> cast()
      _ -> :error
    end
  end

  @doc "Load from the native Ecto representation"
  def load(%Postgrex.INET{}=address), do: {:ok, address}
  def load(_), do: :error

  @doc "Convert to the native Ecto representation"
  def dump(%Postgrex.INET{}=address), do: {:ok, address}
  def dump(_), do: :error

  @doc "Convert from native Ecto representation to a binary"
  def decode(%Postgrex.INET{address: address}) do
    case :inet.ntoa(address) do
      {:error, _einval} -> :error
      formated_address  -> List.to_string(formated_address)
    end
  end

  defp parse_address(address) do
    address
    |> String.to_charlist()
    |> :inet.parse_address()
    |> case do
      {:ok, address} -> address
      {:error, error} -> error
    end
  end
end

defimpl String.Chars, for: Postgrex.INET do
  def to_string(%Postgrex.INET{}=address), do: EctoNetwork.INET.decode(address)
end

if Code.ensure_loaded?(Phoenix.HTML) do
  defimpl Phoenix.HTML.Safe, for: Postgrex.INET do
    def to_iodata(%Postgrex.INET{}=address), do: EctoNetwork.INET.decode(address)
  end
end
