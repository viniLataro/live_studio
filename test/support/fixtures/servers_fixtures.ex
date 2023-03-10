defmodule LiveStudio.ServersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveStudio.Servers` context.
  """

  @doc """
  Generate a server.
  """
  def server_fixture(attrs \\ %{}) do
    {:ok, server} =
      attrs
      |> Enum.into(%{
        deploy_count: 42,
        framework: "some framework",
        last_commit_message: "some last_commit_message",
        name: "some name",
        size: 120.5,
        status: "some status"
      })
      |> LiveStudio.Servers.create_server()

    server
  end
end
