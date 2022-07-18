defmodule BloggerWeb.WelcomeController do
  use BloggerWeb, :controller

  def index(conn, _opts) do
    conn
    |> put_status(:ok)
    |> text("Bem vindo ao Blogger API")
  end
end
