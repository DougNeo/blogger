defmodule Blogger.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Blogger.Repo,
      BloggerWeb.Telemetry,
      {Phoenix.PubSub, name: Blogger.PubSub},
      BloggerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Blogger.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    BloggerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
