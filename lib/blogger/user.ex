defmodule Blogger.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @fields [:display_name, :email, :password, :image]

  @required_params [:display_name, :email, :password]

  @derive {Jason.Encoder, only: [:id, :display_name, :email, :image]}

  schema "users" do
    field :display_name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :image, :string

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_params)
    |> validate_length(:display_name, min: 8)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email, message: "Usuario já existe")
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
