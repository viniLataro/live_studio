defmodule LiveStudio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveStudioWeb.Telemetry,
      # Start the Ecto repository
      LiveStudio.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveStudio.PubSub},
      LiveStudioWeb.Presence,
      # Start Finch
      {Finch, name: LiveStudio.Finch},
      # Start the Endpoint (http/https)
      LiveStudioWeb.Endpoint
      # Start a worker by calling: LiveStudio.Worker.start_link(arg)
      # {LiveStudio.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveStudio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveStudioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
