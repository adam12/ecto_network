defmodule EctoNetwork.CIDR do
  @moduledoc ~S"""
  Support for using Ecto with :cidr fields
  """

  @behaviour Ecto.Type

  def type, do: :cidr

  @doc "Handle embedding format for CIDR records."
  defdelegate embed_as(format), to: EctoNetwork.INET

  @doc "Handle equality testing for CIDR records."
  defdelegate equal?(left, right), to: EctoNetwork.INET

  @doc "Handle casting to Postgrex.INET"
  defdelegate cast(address), to: EctoNetwork.INET

  @doc "Load from the native Ecto representation"
  defdelegate load(address), to: EctoNetwork.INET

  @doc "Convert to the native Ecto representation"
  defdelegate dump(address), to: EctoNetwork.INET

  @doc "Convert from native Ecto representation to a binary"
  defdelegate decode(address), to: EctoNetwork.INET
end
