defmodule GoogleCloudPubSub.MixProject do
  use Mix.Project

  def project do
    [
      app: :google_cloud_pub_sub,
      version: "0.1.0",
      elixir: "~> 1.10",
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
      {:google_api_pub_sub, "~> 0.23.0"},
      {:goth, "~> 1.2"}
    ]
  end
end
