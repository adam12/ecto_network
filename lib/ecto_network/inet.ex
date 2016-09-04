defmodule EctoNetwork.INET do
  @behaviour Ecto.Type

  def type, do: :inet

  def cast(address) when is_binary(address), do: {:ok, address}
  def cast(_), do: :error

  def load(%Postgrex.INET{}=address), do: {:ok, address}
  def load(_), do: :error

  def dump(address) when is_binary(address) do
    case parse_address(address) do
      {:ok, parsed_address} -> {:ok, %Postgrex.INET{address: parsed_address}}
      {:error, _einval}     -> :error
    end
  end

  def dump(_), do: :error

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
