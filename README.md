# Google Cloud PubSub Client

Publishes messages to Google Cloud PubSub.

Uses [Goth](https://github.com/peburrows/goth) for authentication. See docs for configuration.

## Installation

Add `google_cloud_pub_sub` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:google_cloud_pub_sub, git: "https://github.com/ReelCoaches/google_cloud_pub_sub.git"}
  ]
end
```

You will need to configure your credentials for your GCE account according to the instructions on the [Goth](https://github.com/peburrows/goth) README. If you would like to disable Goth when under test, you can add the following to your `test.exs`:

```elixir
config :goth,
  disabled: true
```

## Example Usage

```elixir
topic = "projects/my-project/topics/my-topic"
message = %{"message" => "this is a test"}

{:ok, response} = GoogleCloudPubSub.publish_message(topic, message, nil)
```

