defmodule Blogger.Posts.Get do

  alias Blogger.{Error, Repo, Post}

  def all do
    case Repo.all(Post) do
      nil -> {:error, Error.build(:not_found, "Posts not found")}
      posts -> {:ok, posts}
    end
  end
end
