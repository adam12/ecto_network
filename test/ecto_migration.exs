defmodule Ecto.Integration.Migration do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :macaddr, :macaddr
      add :ip_address, :inet
      add :network, :cidr
      add :networks, {:array, :cidr}
    end
  end
end
