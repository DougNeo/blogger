defmodule BloggerWeb.FallbackController do
  use BloggerWeb, :controller

  alias Blogger.Error
  alias BloggerWeb.ErrorView

  def call(conn, {:error, %Error{status: status, message: message}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", message: message)
  end
end
