defmodule Blogger.Posts.Put do
  alias Blogger.{Error, Post, Repo, User}
  alias Blogger.Posts.Get

  def call(params, user) do
    with {:ok, %Post{} = post} <- Get.by_id(params.id),
        true <- user.id == post.user_id do
          
    end
  end
end
    # case Repo.get(Post, params[:id]) do
    #   nil -> {:error, Error.build(:not_found, "Post não existe")}
    #   post -> {:ok, post}
    # end
