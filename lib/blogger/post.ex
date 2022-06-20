defmodule Blogger.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:title, :content]

  @required_params [:title, :content]

  @derive {Jason.Encoder, only: [:title, :content]}

  schema "posts" do
    field :title, :string
    field :content, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@required_params)
  end
end
