import Config

config :tesla, GoogleApi.PubSub.V1.Connection, adapter: Tesla.Mock

config :goth,
  json: "test/support/test-credentials.json" |> Path.expand() |> File.read!()
