defmodule EctoNetworkTest do
  use ExUnit.Case, async: true
  doctest EctoNetwork

  defmodule Device do
    use Ecto.Schema
    import Ecto.Changeset

    schema "devices" do
      field :macaddr, EctoNetwork.MACADDR
      field :ip_address, EctoNetwork.INET
      field :network, EctoNetwork.CIDR
      field :networks, {:array, EctoNetwork.CIDR}
    end

    @required ~w(macaddr ip_address network networks)

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, @required)
    end
  end

  alias Ecto.Integration.TestRepo

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TestRepo)
  end

  test "accepts mac address as binary and saves" do
    changeset = Device.changeset(%Device{}, %{macaddr: "02:01:00:0A:00:FF"})
    device = TestRepo.insert!(changeset)
    device = TestRepo.get(Device, device.id)

    assert String.downcase("#{device.macaddr}") == String.downcase("02:01:00:0A:00:FF")
  end

  test "accepts ipv4 address as binary and saves" do
    changeset = Device.changeset(%Device{}, %{ip_address: "127.0.0.1"})
    device = TestRepo.insert!(changeset)
    device = TestRepo.get(Device, device.id)

    assert "#{device.ip_address}" == "127.0.0.1"
  end

  test "returns :error when ipv4 is invalid" do
    result = EctoNetwork.INET.cast("abcd")
    assert result == :error
  end

  test "converts ipv4 error into changeset error" do
    changeset = Device.changeset(%Device{}, %{ip_address: "abcd"})
    {:error, changeset} = TestRepo.insert(changeset)
    assert changeset.errors[:ip_address] == {"is invalid", [type: EctoNetwork.INET, validation: :cast]}
  end

  test "accepts ipv6 address as binary and saves" do
    ip_address = "2001:0db8:0000:0000:0000:ff00:0042:8329"
    short_ip_address = "2001:db8::ff00:42:8329"
    changeset = Device.changeset(%Device{}, %{ip_address: ip_address})
    device = TestRepo.insert!(changeset)
    device = TestRepo.get(Device, device.id)

    assert String.downcase("#{device.ip_address}") == String.downcase(short_ip_address)
  end

  test "accepts ipv4 address as tuple and saves" do
    changeset = Device.changeset(%Device{}, %{ip_address: {127,0,0,1}})
    device = TestRepo.insert!(changeset)
    device = TestRepo.get(Device, device.id)

    assert "#{device.ip_address}" == "127.0.0.1"
  end

  test "accepts ipv6 address as tuple and saves" do
    ip_address = {8193, 3512, 0, 0, 0, 65280, 66, 33577}
    short_ip_address = "2001:db8::ff00:42:8329"
    changeset = Device.changeset(%Device{}, %{ip_address: ip_address})
    device = TestRepo.insert!(changeset)
    device = TestRepo.get(Device, device.id)

    assert String.downcase("#{device.ip_address}") == String.downcase(short_ip_address)
  end

  test "accepts cidr address as binary and saves" do
    changeset = Device.changeset(%Device{}, %{network: "127.0.0.0/24"})
    device = TestRepo.insert!(changeset)
    device = TestRepo.get(Device, device.id)

    assert "#{device.network}" == "127.0.0.0/24"
  end

  test "accepts ipv6 cidr as binary and saves" do
    changeset = Device.changeset(%Device{}, %{network: "2001:DB8::/32"})
    device = TestRepo.insert!(changeset)
    device = TestRepo.get(Device, device.id)

    assert String.downcase("#{device.network}") == String.downcase("2001:db8::/32")
  end

  test "accepts array of cidr addresses as binary and saves" do
    changeset = Device.changeset(%Device{}, %{networks: ["127.0.0.0/24", "127.0.1.0/24"]})
    device = TestRepo.insert!(changeset)
    device = TestRepo.get(Device, device.id)

    assert "#{Enum.at(device.networks, 0)}" == "127.0.0.0/24"
    assert "#{Enum.at(device.networks, 1)}" == "127.0.1.0/24"
  end

  test "accepts array of cidr addresses as mixed types and saves" do
    changeset = Device.changeset(%Device{}, %{networks: [
         %Postgrex.CIDR{address: {127, 0, 0, 0}, netmask: 24},
         "127.0.1.0/24"
    ]})

    device = TestRepo.insert!(changeset)
    device = TestRepo.get(Device, device.id)

    assert "#{Enum.at(device.networks, 0)}" == "127.0.0.0/24"
    assert "#{Enum.at(device.networks, 1)}" == "127.0.1.0/24"
  end
end
