# EctoNetwork

[![Module Version](https://img.shields.io/hexpm/v/ecto_network.svg)](https://hex.pm/packages/ecto_network)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ecto_network/)
[![Total Download](https://img.shields.io/hexpm/dt/ecto_network.svg)](https://hex.pm/packages/ecto_network)
[![License](https://img.shields.io/hexpm/l/ecto_network.svg)](https://github.com/adam12/ecto_network/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/adam12/ecto_network.svg)](https://github.com/adam12/ecto_network/commits/master)

Ecto types to support MACADDR and Network extensions provided by Postgrex.

Although this is primarily an Ecto library, it has a hard dependency on Postgrex
due to the types it is providing.

## Installation

1. Add `:ecto_network` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [
        # or 0.7.0 if you're stuck on Ecto < 3
        {:ecto_network, "~> 1.4.0"}
      ]
    end
    ```

2. Create your migrations using the Postgres types as atoms.

    ```elixir
    def change do
      create table(:your_table) do
        add :ip_address, :inet
        add :mac_address, :macaddr
        add :network, :cidr
      end
    end
    ```

3. Use the new types in your Ecto schemas.

    ```elixir
    schema "your_table" do
      field :ip_address, EctoNetwork.INET
      field :mac_address, EctoNetwork.MACADDR
      field :network, EctoNetwork.CIDR
    end
    ```

## Contributing

I love pull requests! If you fork this project and modify it, please ping me to see
if your changes can be incorporated back into this project.

That said, if your feature idea is nontrivial, you should probably open an issue to
[discuss it](http://www.igvita.com/2011/12/19/dont-push-your-pull-requests/)
before attempting a pull request.

## Copyright and License

Copyright (c) 2016 Adam Daniels and contributors

EctoNetwork is released under the MIT License. See [LICENSE.md](./LICENSE.md) for
more information.
