defmodule SdSearch.MixProject do
  use Mix.Project

  def project do
    [
      app: :sd_search,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:machine_gun, "~> 0.1"},
      {:jason, "~> 1.1"},
      {:cortex, "~> 0.5", only: [:dev, :test]}
    ]
  end
end
