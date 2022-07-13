defmodule BloggerWeb.Router do
  use BloggerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BloggerWeb.Auth.Pipeline
  end

  # Escopo sem autenticação
  scope "/", BloggerWeb do
    pipe_through :api

    get "/", WelcomeController, :index
    post "/user", UsersController, :create
    post "/login", UsersController, :login
  end

  # Escopo com autenticação
  scope "/", BloggerWeb do
    pipe_through [:api, :auth]

    get "/user", UsersController, :index
    get "/user/:id", UsersController, :show
    delete "/user/me", UsersController, :destroy
    post "/post", PostsController, :create
    get "/post", PostsController, :index
    put "/post/:id", PostsController, :edit
  end
end
