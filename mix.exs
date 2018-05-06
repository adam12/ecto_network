defmodule EctoNetwork.Mixfile do
  use Mix.Project

  @version "0.7.0"

  def project do
    [
      app: :ecto_network,
      version: @version,
      elixir: "~> 1.3",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "EctoNetwork",
      docs: [
        extras: ["README.md", "CHANGELOG.md"],
        main: "readme",
        source_ref: "v#{@version}",
        source_url: "https://github.com/adam12/ecto_network"
      ]
    ]
  end

  def application do
    [applications: [:logger, :ecto]]
  end

  defp deps do
    # On release, this will need to be set to
    # {:postgrex, ">= 0.14.0"}
    [
      {:db_connection, github: "elixir-ecto/db_connection", override: true},
      {:ecto, github: "elixir-ecto/ecto"},
      {:postgrex, github: "elixir-ecto/postgrex"},
      {:phoenix_html, ">= 0.0.0", [optional: true]},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    """
    Ecto types to support MACADDR and Network extensions provided by Postgrex.
    """
  end

  defp package do
    [
      maintainers: ["Adam Daniels"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/adam12/ecto_network"}
    ]
  end
end
