defmodule EctoNetwork.MACADDR do
  @behaviour Ecto.Type

  def type, do: :macaddr

  def cast(address) when is_binary(address), do: {:ok, address}
  def cast(_), do: :error

  def load(%Postgrex.MACADDR{}=address), do: {:ok, address}
  def load(_), do: :error

  def dump(address) when is_binary(address), do: {:ok, address}
  def dump(_), do: :error

  def decode(%Postgrex.MACADDR{address: {a, b, c, d, e, f}}) do
    [a, b, c, d, e, f]
    |> Enum.map(&Integer.to_string(&1, 16))
    |> Enum.join(":")
  end
end

if Code.ensure_loaded?(Phoenix.HTML) do
  defimpl Phoenix.HTML.Safe, for: Postgrex.MACADDR do
    def to_iodata(%Postgrex.MACADDR{}=address), do: EctoNetwork.MACADDR.decode(address)
  end
end
