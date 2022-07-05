defmodule BloggerWeb.UsersView do
  use BloggerWeb, :view

  alias Blogger.User

  def render("create.json", %{user: %User{} = user, token: token}) do
    %{
      user: user,
      token: token
    }
  end
end
