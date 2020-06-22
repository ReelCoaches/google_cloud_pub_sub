defmodule GoogleCloudPubSub do
  @moduledoc """
  Documentation for `GoogleCloudPubSub`.
  """
  alias GoogleApi.PubSub.V1.Api.Projects
  alias GoogleApi.PubSub.V1.Connection
  alias GoogleApi.PubSub.V1.Model.PublishRequest
  alias GoogleApi.PubSub.V1.Model.PubsubMessage
  require Logger

  @default_scope "https://www.googleapis.com/auth/pubsub"

  def publish_message(topic, message, attributes, opts \\ []) do
    token_module = Keyword.get(opts, :token_module, Goth.Token)
    scope = Keyword.get(opts, :scope, @default_scope)

    {:ok, token} = token_module.for_scope(scope)
    conn = Connection.new(token.token)

    with {:ok, project_id, topic_name} <- parse_topic(topic),
         {:ok, string_encoded} <- Jason.encode(message),
         request = %PublishRequest{
           messages: [
             %PubsubMessage{
               data: Base.encode64(string_encoded),
               attributes: attributes
             }
           ]
         },
         {:ok, response} <-
           Projects.pubsub_projects_topics_publish(
             conn,
             project_id,
             topic_name,
             body: request
           ) do
      Logger.debug("Published message: #{inspect(message)}")

      {:ok, response}
    end
  end

  defp parse_topic(topic) do
    case String.split(topic, "/") do
      ["projects", project, "topics", topic] ->
        {:ok, project, topic}

      _ ->
        {:error, :parse_error}
    end
  end
end
