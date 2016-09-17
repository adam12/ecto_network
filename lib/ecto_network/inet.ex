defmodule EctoNetwork.INET do
  @moduledoc ~S"""
  Support for using Ecto with :inet fields
  """

  @behaviour Ecto.Type

  def type, do: :inet

  @doc "Handle casting to Postgrex.INET"
  def cast(%Postgrex.INET{}=address), do: {:ok, address}
  def cast(address) when is_binary(address) do
    case parse_address(address) do
      {:ok, parsed_address} -> {:ok, %Postgrex.INET{address: parsed_address}}
      {:error, _einval}     -> :error
    end
  end
  def cast(_), do: :error

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
    address |> String.to_char_list |> :inet.parse_address
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
