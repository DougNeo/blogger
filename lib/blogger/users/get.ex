defmodule Blogger.Users.Get do
  alias Blogger.{Error, Repo, User}

  def all do
    case Repo.all(User) do
      [] -> {:error, Error.build(:not_found, "Usuários não existem")}
      users -> {:ok, users}
    end
  end

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build(:not_found, "Usuário não existe")}
      user -> {:ok, user}
    end
  end

  def by_email(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, Error.build(:bad_request, "Campos inválidos")}
      user -> {:ok, user}
    end
  end
end
