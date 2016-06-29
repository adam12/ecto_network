defmodule EctoNetworkTest do
  use ExUnit.Case, async: true
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
    device = TestRepo.insert!(%Device{macaddr: "2:1:0:A:0:FF"})
    device = TestRepo.get(Device, device.id)

    assert "#{device.macaddr}" == "2:1:0:A:0:FF"
  end

  test "accepts ip address as binary and saves" do
    device = TestRepo.insert!(%Device{ip_address: "127.0.0.1"})
    device = TestRepo.get(Device, device.id)

    assert "#{device.ip_address}" == "127.0.0.1"
  end
end
