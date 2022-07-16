defmodule Blogger.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blogger.User

  @fields [:title, :content]

  @required_params [:title, :content]

  @derive {Jason.Encoder, only: [:title, :content, :user_id]}

  schema "posts" do
    field :title, :string
    field :content, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_params, message: "is required")
  end
end
