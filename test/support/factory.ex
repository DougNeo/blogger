defmodule Blogger.Factory do
  use ExMachina.Ecto, repo: Blogger.Repo

  def user_params_factory do
    %{
      display_name: "Fulano de Tal",
      email: "fulano@email.com",
      password: "123456",
      image: "http://example.com/image.jpg"
    }
  end

  def user_factory do
    %Blogger.User{
      display_name: "Fulano de Tal",
      email: "fulano@email.com",
      password: "123456",
      image: "http://example.com/image.jpg",
      id: 1
    }
  end

  def post_factory do
    %Blogger.Post{
      title: "Post Title",
      content: "Post Body"
    }
  end
end
