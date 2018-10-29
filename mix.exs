defmodule EctoNetwork.Mixfile do
  use Mix.Project

  @version "1.0.0-rc.0"

  def project do
    [
      app: :ecto_network,
      version: @version,
      elixir: "~> 1.5",
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
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ecto_sql, "3.0.0-rc.0"},
      {:postgrex, "0.14.0-rc.1"},
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
