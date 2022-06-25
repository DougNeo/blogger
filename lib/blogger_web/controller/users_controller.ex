defmodule BloggerWeb.UsersController do
  use BloggerWeb, :controller

  alias Blogger.User
  alias Blogger.Users

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.Create.call(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, params) do
    with {:ok, %User{} = user} <- Users.Get.by_id(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def destroy(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Users.Delete.call(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Users.Update.call(params) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
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
