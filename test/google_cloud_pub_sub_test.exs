defmodule GoogleCloudPubSubTest do
  use ExUnit.Case

  defmodule TestToken do
    def for_scope(scope) do
      {:ok,
       %Goth.Token{
         scope: scope,
         expires: :os.system_time(:seconds) + 3600,
         type: "Bearer",
         token: "XXXXAAABBBCCEEEDASDFSDFWERSDFAS"
       }}
    end
  end

  setup do
    test_pid = self()

    Tesla.Mock.mock(fn %{url: url, body: body} ->
      send(test_pid, {:http_request_called, %{url: url, body: body}})

      %Tesla.Env{
        status: 200,
        body: body
      }
    end)

    :ok
  end

  test "publishes messages" do
    test_topic = "projects/my-project/topics/my-topic"
    test_message = %{"message" => "this is a test"}

    assert {:ok, response} =
             GoogleCloudPubSub.publish_message(test_topic, test_message, nil,
               token_module: TestToken
             )

    assert_received {:http_request_called, %{body: body, url: url}}
    body = Jason.decode!(body)
    [message | _] = body["messages"]
    decoded_message = Jason.decode!(Base.decode64!(message["data"]))
    assert decoded_message == test_message

    assert url == "https://pubsub.googleapis.com/v1/projects/my-project/topics/my-topic:publish"
  end
end
