defmodule Blogger.UserTest do
  use Blogger.DataCase, async: true
  import Blogger.Factory
  alias Blogger.User
  alias Ecto.Changeset

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params, email: "fulano@email.com")

      response = User.changeset(params)

      assert %Changeset{
               changes: %{
                 displayName: "Fulano de Tal",
                 email: "fulano@email.com",
                 image: "http://example.com/image.jpg"
               },
               valid?: true
             } = response
    end
  end

  test "when there are some error, returns an invalid changeset" do
    params = build(:user_params, %{email: "fulano", password: "123"})

    response = User.changeset(params)

    assert %Changeset{
             errors: [
               email: {"must be a valid email", [validation: :format]},
               password:
                 {"length must be at least 6 characters long",
                  [count: 6, validation: :length, kind: :min, type: :string]}
             ],
             valid?: false
           } = response
  end
end
