defmodule BloggerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :blogger,
                              module: BloggerWeb.Auth.Guardian,
                              error_handler: BloggerWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
