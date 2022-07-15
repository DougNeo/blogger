defmodule Blogger.Posts.Get do

  alias Blogger.{Error, Repo, Post}

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
end
