# EctoNetwork

Ecto types to support MACADDR and Network extensions provided by Postgrex.

## Installation

1. Add `ecto_network` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ecto_network, "~> 0.1.0"}]
    end
    ```
2. Setup Postgrex extensions for MACADDR and/or Network (INET, CIDR).

    ```elixir
    extensions: [
      {Postgrex.Extensions.MACADDR, nil},
      {Postgrex.Extensions.Network, nil}
    ],
    ```
