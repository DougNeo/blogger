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

    scope "/post" do
      get "/search", PostsController, :search
      get "/", PostsController, :index
      get "/:id", PostsController, :show
      post "/", PostsController, :create
      put "/:id", PostsController, :edit
      delete "/:id", PostsController, :destroy
    end

    scope "/user" do
      get "/", UsersController, :index
      get "/:id", UsersController, :show
      delete "/me", UsersController, :destroy
    end
  end
end
