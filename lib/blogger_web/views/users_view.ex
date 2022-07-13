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
    user
  end

  def render("users.json", %{users: users}) do
    Enum.map(users, fn user ->
      %{
        id: user.id,
        displayName: user.displayName,
        email: user.email,
        image: user.image
      }
    end)
  end
end
