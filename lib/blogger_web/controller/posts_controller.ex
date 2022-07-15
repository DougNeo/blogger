defmodule BloggerWeb.PostsController do
  use BloggerWeb, :controller

  alias BloggerWeb.Auth.Guardian
  alias Blogger.Posts.{Create, Get, Put}
  alias Blogger.{Repo, Post}
  alias BloggerWeb.FallbackController
  alias Blogger.User

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user, _claims} <- Guardian.resource_from_token(conn.private.guardian_default_token),
      {:ok, %Post{} = post} <- Create.call(params, user) do
      conn
      |> put_status(:created)
      |> render("create.json", post: post)
    end
  end

  def index(conn, _params) do
    with {:ok, posts} <- Get.all(),
    posts_loaded <- Repo.preload(posts, :user) do
      conn
      |> put_status(:ok)
      |> render("posts.json", posts_loaded: posts_loaded)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, post} <- Get.by_id(id),
    post_loaded <- Repo.preload(post, :user) do
      conn
      |> put_status(:ok)
      |> render("post.json", post_loaded: post_loaded)
    end
  end

  def edit(conn, params) do
    with {:ok, %User{} = user, _claims} <- Guardian.resource_from_token(conn.private.guardian_default_token),
    {:ok, post_update} <- Put.call(params, user),
      post_update_loaded <- Repo.preload(post_update, :user) do
        conn
        |> put_status(:ok)
        |> render("post.json", post_update_loaded: post_update_loaded)
    end
  end
end
