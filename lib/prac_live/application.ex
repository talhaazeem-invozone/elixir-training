defmodule PracLive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PracLive.Repo,
      # Start the Telemetry supervisor
      PracLiveWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PracLive.PubSub},
      # Start the Endpoint (http/https)
      PracLiveWeb.Endpoint
      # Start a worker by calling: PracLive.Worker.start_link(arg)
      # {PracLive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PracLive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PracLiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
