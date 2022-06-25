defmodule BloggerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :blogger

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
