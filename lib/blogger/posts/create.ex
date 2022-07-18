defmodule Blogger.Posts.Create do
  alias Blogger.{Error, Post, Repo}

  def call(params, user) do
    user
    |> Ecto.build_assoc(:posts, params)
    |> Post.changeset(params)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Post{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
