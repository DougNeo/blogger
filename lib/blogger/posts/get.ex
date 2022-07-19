defmodule Blogger.Posts.Get do
  alias Blogger.{Error, Post, Repo}
  import Ecto.Query

  def all do
    case Repo.all(Post) do
      nil -> {:error, Error.build(:not_found, "Posts não existem")}
      posts -> {:ok, posts}
    end
  end

  def by_id(id) do
    case Repo.get(Post, id) do
      nil -> {:error, Error.build(:not_found, "Post não existe")}
      post -> {:ok, post}
    end
  end

  def by_content_or_title(term) do
    case term do
      nil ->
        {:ok, Repo.all(Post)}

      "" ->
        {:ok, Repo.all(Post)}

      _ ->
        q = "%#{term}%"

        query = from(u in Post, where: ilike(u.title, ^q) or ilike(u.content, ^q))

        case Repo.all(query) |> Repo.preload(:user) do
          [] -> {:ok, []}
          posts -> {:ok, posts}
        end
    end
  end
end
