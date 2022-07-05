defmodule BloggerWeb.UsersController do
  use BloggerWeb, :controller

  alias Blogger.User
  alias BloggerWeb.Auth.Guardian
  alias Blogger.Users.{Create, Delete, Get, Update}
  alias BloggerWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user, token: token)
    end
  end

  def show(conn, params) do
    with {:ok, %User{} = user} <- Get.by_id(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def destroy(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Delete.call(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Update.call(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def login(conn, params) do
    with {:ok, token, _claims} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("login.json", token: token)
    end
  end

  # def index(params) do
  #   with {:ok, %User{} = user} <- Users.Get.by_id(params) do
  #     conn
  #     |> put_status(:ok)
  #     |> render("user.json", user: user)
  #   end
  # end
end
