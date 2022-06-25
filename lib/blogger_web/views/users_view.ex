defmodule BloggerWeb.UsersView do
  use BloggerWeb, :view

  alias Blogger.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      user: user
    }
  end
end
