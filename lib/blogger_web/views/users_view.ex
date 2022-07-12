defmodule BloggerWeb.UsersView do
  use BloggerWeb, :view

  alias Blogger.User

  def render("create.json", %{token: token}) do
    %{
      token: token
    }
  end

  def render("login.json", %{token: token}) do
    %{
      token: token
    }
  end

  def render("user.json", %{user: %User{} = user}) do
    %{
      user: user
    }
  end
end
