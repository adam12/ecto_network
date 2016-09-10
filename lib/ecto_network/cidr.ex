defmodule EctoNetwork.CIDR do
  @behaviour Ecto.Type

  def type, do: :cidr

  def cast(%Postgrex.CIDR{}=address), do: {:ok, address}
  def cast(address) when is_binary(address) do
    [address, netmask] = address |> String.split("/")

    [a, b, c, d] =
      address
      |> String.split(".")
      |> Enum.map(&String.to_integer/1)


    netmask = netmask |> String.to_integer()

    {:ok, %Postgrex.CIDR{address: {a, b, c, d}, netmask: netmask}}
  end
  def cast(_), do: :error

  def load(%Postgrex.CIDR{}=address), do: {:ok, address}
  def load(_), do: :error

  def dump(%Postgrex.CIDR{}=address), do: {:ok, address}

  def dump(_), do: :error

  def decode(%Postgrex.CIDR{address: {a, b, c, d}, netmask: netmask}) do
    address =
      [a, b, c, d]
      |> Enum.join(".")

    "#{address}/#{netmask}"
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
