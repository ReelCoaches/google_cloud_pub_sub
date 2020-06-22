# Google Cloud PubSub Client

Publishes messages to Google Cloud PubSub.

Uses [Goth]() for authentication. See docs for configuration.

## Installation

Add `google_cloud_pub_sub` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:google_cloud_pub_sub, git: "https://github.com/ReelCoaches/google_cloud_pub_sub.git"}
  ]
end
```

## Example Usage

```elixir
topic = "projects/my-project/topics/my-topic"
message = %{"message" => "this is a test"}

{:ok, response} = GoogleCloudPubSub.publish_message(topic, message, nil)
```

