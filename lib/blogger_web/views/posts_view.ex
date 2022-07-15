defmodule BloggerWeb.PostsView do
  use BloggerWeb, :view

  alias Blogger.Post

  def render("create.json", %{post: %Post{} = post}) do
    %{
      title: post.title,
      content: post.content,
      userId: post.user_id,
    }
  end

  def render("posts.json", %{posts_loaded: posts}) do
    Enum.map(posts, fn post ->
      %{
        id: post.id,
        published: post.inserted_at,
        updated: post.updated_at,
        title: post.title,
        content: post.content,
        user: post.user
      }
    end)
  end
end
