defmodule Masterpiece.MixProject do
    use Mix.Project

    def project do
        [
            app: :masterpiece,
            version: "0.1.0",
            elixir: "~> 1.10",
            start_permanent: Mix.env() == :prod,
            deps: deps()
        ]
    end

    # Run "mix help compile.app" to learn about applications.
    def application do
        [
            extra_applications: [:logger, :iex],
            mod: {Masterpiece.Application, []}
        ]
    end

    # Run "mix help deps" to learn about dependencies.
    defp deps do
        [
            {:jason, "~> 1.2"},
            {:yaml_elixir, "~> 2.8"},
            {:plug_cowboy, "~> 2.0"},
            {:plug, "~> 1.10"},
        ]
    end
end
