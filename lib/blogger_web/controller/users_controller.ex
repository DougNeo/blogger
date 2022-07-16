defmodule BloggerWeb.UsersController do
  use BloggerWeb, :controller

  alias Blogger.User
  alias BloggerWeb.Auth.Guardian
  alias Blogger.Users.{Create, Delete, Get}
  alias BloggerWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Get.by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def destroy(conn, _params) do
    with {:ok, %User{id: id}, _claims} <-
           Guardian.resource_from_token(conn.private.guardian_default_token),
         {:ok, %User{}} <- Delete.call(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def login(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("login.json", token: token)
    end
  end

  def index(conn, _params) do
    with {:ok, users} <- Get.all() do
      conn
      |> put_status(:ok)
      |> render("users.json", users: users)
    end
  end
end
