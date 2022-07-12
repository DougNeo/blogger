defmodule Blogger.Users.Create do
  alias Blogger.{Error, Repo, User}
  alias Ecto.Changeset

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, %Changeset{errors: [email: {"Usuário já existe", _}]} = result}) do
    {:error, Error.build(:conflict, result)}
  end

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
