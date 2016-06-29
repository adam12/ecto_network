defmodule Ecto.Integration.Migration do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :macaddr, :macaddr #EctoNetwork.MACADDR
      add :ip_address, :inet #EctoNetwork.INET
      add :network, :cidr #EctoNetwork.CIDR
    end
  end
end
