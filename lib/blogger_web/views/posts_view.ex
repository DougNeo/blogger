defmodule BloggerWeb.PostsView do
  use BloggerWeb, :view

  alias Blogger.Post

  def render("create.json", %{post: %Post{} = post}) do
    post
  end
end
