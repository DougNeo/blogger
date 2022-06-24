defmodule Blogger.Users.Delete do
  alias Blogger.{Error, Repo, User}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build(:not_found, "User not found")}
      user -> Repo.delete(user)
    end
  end
end
