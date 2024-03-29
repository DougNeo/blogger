defmodule BloggerWeb.PostsController do
  use BloggerWeb, :controller

  alias BloggerWeb.Auth.Guardian
  alias BloggerWeb.FallbackController
  alias Blogger.Posts.{Create, Delete, Get, Put}
  alias Blogger.{Error, Post, Repo}
  alias Blogger.User
  alias Ecto.Changeset

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user, _claims} <-
           Guardian.resource_from_token(conn.private.guardian_default_token),
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
    with {:ok, %User{} = user, _claims} <-
           Guardian.resource_from_token(conn.private.guardian_default_token),
         {:ok, %Post{} = post} <- Get.by_id(params["id"]),
         true <- user.id == post.user_id,
         %Changeset{valid?: true} <-
           Blogger.Post.changeset(params) |> Ecto.Changeset.validate_required([:title, :content]),
         {:ok, post_update} <- Put.call(params),
         post_loaded <- Repo.preload(post_update, :user) do
      conn
      |> put_status(:ok)
      |> render("update.json", post_loaded: post_loaded)
    else
      false ->
        {:error, Error.build(:unauthorized, "Usuário não autorizado")}

      %Changeset{valid?: false, errors: [content: {_, [_]}]} ->
        {:error, Error.build(:bad_request, ~S("content" is required))}

      %Changeset{valid?: false, errors: [title: {_, [_]}]} ->
        {:error, Error.build(:bad_request, ~S("title" is required))}

      %Changeset{valid?: false, errors: [_, _]} ->
        {:error, Error.build(:bad_request, ~S("content" is required, "title" is required))}
    end
  end

  def destroy(conn, %{"id" => id}) do
    with {:ok, %User{} = user, _claims} <-
           Guardian.resource_from_token(conn.private.guardian_default_token),
         {:ok, %Post{} = post} <- Get.by_id(id),
         true <- user.id == post.user_id,
         {:ok, %Post{}} <- Delete.call(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    else
      false ->
        {:error, Error.build(:unauthorized, "Usuário não autorizado")}
    end
  end

  def search(conn, %{"q" => query}) do
    with {:ok, posts} <- Get.by_content_or_title(query),
         posts_loaded <- Repo.preload(posts, :user) do
      conn
      |> put_status(:ok)
      |> render("posts.json", posts_loaded: posts_loaded)
    end
  end
end
