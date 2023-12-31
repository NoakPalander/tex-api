defmodule Tex.MixProject do
  use Mix.Project

  def project do
    [
      app: :tex,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Tex.Application, [:eex]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.4.0"},
      {:iona, "~> 0.4"},
      {:briefly, "~> 0.4.0"}
    ]
  end
end
