defmodule Blogger.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blogger.Post
  alias Ecto.Changeset

  @fields [:displayName, :email, :password, :image]

  @required_params [:displayName, :email, :password]

  @derive {Jason.Encoder, only: [:id, :displayName, :email, :image]}

  schema "users" do
    field :displayName, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :image, :string
    has_many :posts, Post

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_params, message: "is required")
    |> validate_length(:displayName, min: 8, message: "length must be at least 8 characters long")
    |> validate_length(:password, min: 6, message: "length must be at least 6 characters long")
    |> validate_format(:email, ~r/[a-z0-9.]+@[a-z0-9]/, message: "must be a valid email")
    |> unique_constraint(:email, message: "Usuário já existe")
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
