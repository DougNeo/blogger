defmodule BloggerWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :blogger

  @session_options [
    store: :cookie,
    key: "_blogger_key",
    signing_salt: "ZVf95fpg"
  ]

  plug Plug.Static,
    at: "/",
    from: :blogger,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :blogger
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug BloggerWeb.Router
end
