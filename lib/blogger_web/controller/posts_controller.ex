defmodule BloggerWeb.PostsController do
  use BloggerWeb, :controller

  alias Blogger.Posts.Create
  alias Blogger.Post
  alias BloggerWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Post{} = post} <- Create.call(params) do
      conn
      |> put_status(:created)
      |> render("create.json", post: post)
    end

  end

  def index(conn, params) do
    # ...
  end

  def edit(conn, params) do
    # ...
  end
end
