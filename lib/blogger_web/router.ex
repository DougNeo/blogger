defmodule BloggerWeb.Router do
  use BloggerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BloggerWeb do
    pipe_through :api
  end
end
