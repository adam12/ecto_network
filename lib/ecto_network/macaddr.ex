defmodule EctoNetwork.MACADDR do
  @moduledoc ~S"""
  Support for using Ecto with `:macaddr` fields.
  """

  @behaviour Ecto.Type

  def type, do: :macaddr

  @doc "Handle embedding format for CIDR records."
  def embed_as(_), do: :self

  @doc "Handle equality testing for CIDR records."
  def equal?(left, right), do: left == right

  @doc "Handle casting to Postgrex.MACADDR."
  def cast(%Postgrex.MACADDR{} = address), do: {:ok, address}

  def cast(address) when is_binary(address) do
    with [a, b, c, d, e, f] <- parse_address(address) do
      {:ok, %Postgrex.MACADDR{address: {a, b, c, d, e, f}}}
    end
  end

  @doc "Load from the native Ecto representation."
  def load(%Postgrex.MACADDR{} = address), do: {:ok, address}
  def load(_), do: :error

  @doc "Convert to the native Ecto representation."
  def dump(%Postgrex.MACADDR{} = address), do: {:ok, address}
  def dump(_), do: :error

  @doc "Convert from native Ecto representation to a binary."
  def decode(%Postgrex.MACADDR{address: {a, b, c, d, e, f}}) do
    [a, b, c, d, e, f]
    |> Enum.map(&Integer.to_string(&1, 16))
    |> Enum.map(&String.pad_leading(&1, 2, "0"))
    |> Enum.join(":")
  end

  defp parse_address(address) do
    with split when length(split) == 6 <- String.split(address, ":"),
         [_ | _] = parsed <- Enum.reduce_while(split, [], &parse_octet/2) do
      Enum.reverse(parsed)
    else
      _ -> :error
    end
  end

  defp parse_octet(octet, acc) do
    with {int, ""} <- Integer.parse(octet, 16) do
      {:cont, [int | acc]}
    else
      _ -> {:halt, :error}
    end
  end
end

defimpl String.Chars, for: Postgrex.MACADDR do
  def to_string(%Postgrex.MACADDR{} = address), do: EctoNetwork.MACADDR.decode(address)
end

if Code.ensure_loaded?(Phoenix.HTML) do
  defimpl Phoenix.HTML.Safe, for: Postgrex.MACADDR do
    def to_iodata(%Postgrex.MACADDR{} = address), do: EctoNetwork.MACADDR.decode(address)
  end
end
