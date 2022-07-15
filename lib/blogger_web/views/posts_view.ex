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

  def render("post.json", %{post_loaded: post_loaded}) do
    %{
      id: post_loaded.id,
      published: post_loaded.inserted_at,
      updated: post_loaded.updated_at,
      title: post_loaded.title,
      content: post_loaded.content,
      user: post_loaded.user
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
