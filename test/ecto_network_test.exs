defmodule EctoNetworkTest do
  use ExUnit.Case
  doctest EctoNetwork

  import Ecto.Changeset

  defmodule Device do
    use Ecto.Schema

    schema "devices" do
      field :macaddr, EctoNetwork.MACADDR
      field :ip_address, EctoNetwork.INET
      field :network, EctoNetwork.CIDR
    end
  end

  alias Ecto.Integration.TestRepo

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TestRepo)
  end

  test "accepts mac address as binary and saves" do
    device = TestRepo.insert!(%Device{macaddr: "02:01:00:0A:00:FF"})
    device = TestRepo.get(Device, device.id)

    assert device.macaddr == "02:01:00:0A:00:FF"
  end
end
