defmodule Blogger.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :displayName, :string
      add :email, :string
      add :password_hash, :string
      add :image, :string

      timestamps()
    end

    create index("users", :email, unique: true)
  end
end
