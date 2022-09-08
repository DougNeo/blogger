defmodule BloggerWeb.Auth.ErrorHandler do
  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  def auth_error(conn, {error, _reason}, _opts) do
    case error do
      # :no_resource_found ->
      #   Conn.send_resp(conn, 401, Jason.encode!(%{message: "token invalido"}))

      :unauthenticated ->
        Conn.send_resp(conn, 401, Jason.encode!(%{message: "Token não encontrado"}))

      :invalid_token ->
        Conn.send_resp(conn, 401, Jason.encode!(%{message: "Token expirado ou inválido"}))

      _ ->
        Conn.send_resp(conn, 401, Jason.encode!(%{message: to_string(error)}))
    end
  end
end
