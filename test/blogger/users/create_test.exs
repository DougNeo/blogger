defmodule Blogger.Users.CreateTest do
  use Blogger.DataCase, async: true
  import Blogger.Factory

  describe "call/1" do
    test "when all params are valid, returns a valid user" do
      params = build(:user_params)

      response = Blogger.Users.Create.call(params)

      assert {:ok,
              %Blogger.User{
                displayName: "Fulano de Tal",
                email: _email,
                id: _1,
                image: "http://example.com/image.jpg"
              }} = response
    end

    test "quando o email já tem no banco da erro" do
      insert(:user, %{email: "fulano@email.com"})
      params = build(:user_params, %{email: "fulano@email.com"})

      response = Blogger.Users.Create.call(params)

      assert {:error,
              %Blogger.Error{
                message: %Ecto.Changeset{
                  errors: [
                    email:
                      {"Usuário já existe",
                       [constraint: :unique, constraint_name: "users_email_index"]}
                  ],
                  valid?: false
                },
                status: :conflict
              }} = response
    end

    test "qualquer outro erro" do
      params = build(:user_params, %{email: "fulano", password: "123", displayName: "Doug"})

      response = Blogger.Users.Create.call(params)

      assert {:error,
              %Blogger.Error{
                message: %Ecto.Changeset{
                  errors: [
                    email: {"must be a valid email", [validation: :format]},
                    password:
                      {"length must be at least 6 characters long",
                       [count: 6, validation: :length, kind: :min, type: :string]},
                    displayName:
                      {"length must be at least 8 characters long",
                       [count: 8, validation: :length, kind: :min, type: :string]}
                  ],
                  valid?: false
                },
                status: :bad_request
              }} = response
    end
  end
end
