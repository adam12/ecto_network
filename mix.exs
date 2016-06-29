defmodule EctoNetwork.Mixfile do
  use Mix.Project

  def project do
    [app: :ecto_network,
     version: "0.2.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: description(),
     package: package()]
  end

  def application do
    [applications: [:logger, :ecto]]
  end

  defp deps do
    [{:ecto, ">= 0.0.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, ">= 0.0.0", [optional: true]},
     {:ex_doc, ">= 0.0.0", only: :dev}]
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
