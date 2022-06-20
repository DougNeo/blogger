defmodule Blogger.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :display_name, :string
      add :email, :string
      add :password_hash, :string
      add :image, :string

      timestamps()
    end
  end
end
