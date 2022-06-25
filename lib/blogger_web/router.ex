defmodule BloggerWeb.Router do
  use BloggerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BloggerWeb do
    pipe_through :api
    get "/", WelcomeController, :index

    scope "user" do
      post "/", UsersController, :create
      get "/", UsersController, :index
      get "/:id", UsersController, :show
      delete "/me", UsersController, :destroy
    end

    scope "post" do
      post "/", PostsController, :create
      get "/", PostsController, :index
      put "/:id", PostsController, :edit
    end
  end
end
