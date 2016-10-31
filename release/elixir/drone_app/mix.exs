defmodule DroneApp.Mixfile do
  use Mix.Project

  def project do
    [app: :drone_app,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger],
     mod: {DroneApp, []}]
  end

  defp deps do
    [{:exrm, "~> 1.0.8"}]
  end
end
