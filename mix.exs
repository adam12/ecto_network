defmodule EctoNetwork.Mixfile do
  use Mix.Project

  @source_url "https://github.com/adam12/ecto_network"
  @version "1.5.0"

  def project do
    [
      app: :ecto_network,
      version: @version,
      elixir: "~> 1.9",
      name: "EctoNetwork",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs(),
      lockfile: lockfile()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.14.0", only: :test},
      {:ecto_sql, ">= 3.0.0"},
      {:postgrex, ">= 0.14.0"},
      {:phoenix_html, ">= 0.0.0", [optional: true]},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      description: "Ecto types to support MACADDR and Network extensions provided by Postgrex.",
      maintainers: ["Adam Daniels"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "https://hexdocs.pm/ecto_network/changelog.html",
        "GitHub" => @source_url
      }
    ]
  end

  defp lockfile do
    System.get_env("LOCKFILE", "mix.lock")
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md",
        {:"LICENSE.md", title: ["License"]},
        "README.md"
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
