defmodule Blogger.Posts.Put do
  alias Blogger.{Error, Post, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Post, id) do
      nil -> {:error, Error.build(:not_found, "Post não existe")}
      post -> do_update(post, params)
    end
  end

  defp do_update(post, params) do
    post
    |> Post.changeset(params)
    |> Repo.update()
  end
end
