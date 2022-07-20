defmodule Blogger.Users.Index do
  alias Blogger.{Error, Repo, User}

  def call do
    case Repo.all(User) do
      [] -> {:ok, []}
      users -> {:ok, users}
    end
  end
end
