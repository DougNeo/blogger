defmodule Blogger.Users.Index do
  alias Blogger.{Error, Repo, User}

  def call() do
    case Repo.all(User) do
      nil -> {:error, Error.build(:not_found, "User not found")}
      user -> {:ok, user}
    end
  end
end
