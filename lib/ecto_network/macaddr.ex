defmodule EctoNetwork.MACADDR do
  @behaviour Ecto.Type

  def type, do: :macaddr

  def cast(%Postgrex.MACADDR{}=address), do: {:ok, address}
  def cast(address) when is_binary(address) do
    [a, b, c, d, e, f] =
      address
      |> String.split(":")
      |> Enum.map(&String.to_integer(&1, 16))

    {:ok, %Postgrex.MACADDR{address: {a, b, c, d, e, f}}}
  end

  def load(%Postgrex.MACADDR{}=address), do: {:ok, address}
  def load(_), do: :error

  def dump(%Postgrex.MACADDR{}=address), do: {:ok, address}
  def dump(_), do: :error

  def decode(%Postgrex.MACADDR{address: {a, b, c, d, e, f}}) do
    [a, b, c, d, e, f]
    |> Enum.map(&Integer.to_string(&1, 16))
    |> Enum.join(":")
  end
end

defimpl String.Chars, for: Postgrex.MACADDR do
  def to_string(%Postgrex.MACADDR{}=address), do: EctoNetwork.MACADDR.decode(address)
end

if Code.ensure_loaded?(Phoenix.HTML) do
  defimpl Phoenix.HTML.Safe, for: Postgrex.MACADDR do
    def to_iodata(%Postgrex.MACADDR{}=address), do: EctoNetwork.MACADDR.decode(address)
  end
end
