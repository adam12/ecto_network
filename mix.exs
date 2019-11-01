defmodule EctoNetwork.Mixfile do
  use Mix.Project

  @version "1.2.0"

  def project do
    [
      app: :ecto_network,
      version: @version,
      elixir: "~> 1.4",
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
      ],
      lockfile: lockfile()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ecto_sql, ">= 3.0.0"},
      {:postgrex, ">= 0.14.0"},
      {:phoenix_html, ">= 0.0.0", [optional: true]},
      {:ex_doc, "~> 0.19", only: :dev}
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

  defp lockfile do
    if function_exported?(System, :get_env, 2) do
      System.get_env("LOCKFILE", "mix.lock")
    else
      System.get_env("LOCKFILE") || "mix.lock"
    end
  end
end
