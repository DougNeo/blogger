defmodule Blogger.Factory do
  use ExMachina.Ecto, repo: Blogger.Repo

  def user_params_factory do
    %{
      displayName: "Fulano de Tal",
      email: sequence(:email, &"fulano-#{&1}@email.com", start_at: 1),
      password: "123456",
      image: "http://example.com/image.jpg"
    }
  end

  def user_factory do
    %Blogger.User{
      displayName: "Fulano de Tal",
      email: sequence(:email, &"fulano-#{&1}@email.com", start_at: 1),
      password: "123456",
      image: "http://example.com/image.jpg",
      id: sequence(:id, &"#{&1}", start_at: 1)
    }
  end

  def post_params_factory do
    %{
      title: "Post Title",
      content: "Post Body"
    }
  end

  def post_factory do
    %Blogger.Post{
      title: "Post Title",
      content: "Post Body"
    }
  end
end
