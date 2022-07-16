defmodule Blogger.Posts.Delete do
  alias Blogger.{Error, Repo, Post}

  def call(id) do
    case Repo.get(Post, id) do
      nil -> {:error, Error.build(:not_found, "Post not found")}
      post -> Repo.delete(post)
    end
  end
end
