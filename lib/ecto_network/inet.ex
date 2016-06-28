defmodule EctoNetwork.INET do
  @behaviour Ecto.Type

  def type, do: :inet

  def cast(address) when is_binary(address), do: {:ok, address}
  def cast(_), do: :error

  def load(%Postgrex.INET{}=address), do: {:ok, address}
  def load(_), do: :error

  def dump(address) when is_binary(address), do: {:ok, address}
  def dump(_), do: :error

  def decode(%Postgrex.INET{address: {a, b, c, d}}) do
    [a, b, c, d]
    |> Enum.join(".")
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
