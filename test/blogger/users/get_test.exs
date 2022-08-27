defmodule Blogger.Users.GetTest do
  use Blogger.DataCase, async: true
  import Blogger.Factory
  alias Blogger.User

  describe "all/0" do
    test "when there are users, returns them" do
      insert_list(2, :user)

      response = Blogger.Users.Get.all()

      assert {:ok, [%User{}, %User{}]} = response
    end

    test "when there are no users, returns an empty array" do
      response = Blogger.Users.Get.all()

      assert {:error, %Blogger.Error{message: "Usuários não existem", status: :not_found}} =
               response
    end
  end

  describe "by_id/1" do
    test "when id is valid, returns the user" do
      user = insert(:user)

      response = Blogger.Users.Get.by_id(user.id)

      assert {:ok, _user} = response
    end

    test "when id is not valid, error user not found" do
      response = Blogger.Users.Get.by_id(999)

      assert {:error, %Blogger.Error{message: "Usuário não existe", status: :not_found}} =
               response
    end
  end

  describe "by_email/1" do
    test "when email is valid, returns the user" do
      user = insert(:user)

      response = Blogger.Users.Get.by_email(user.email)

      assert {:ok, _user} = response
    end

    test "when email is not valid, error user not found" do
      response = Blogger.Users.Get.by_email("email@email.com")

      assert {:error, %Blogger.Error{message: "Campos inválidos", status: :bad_request}} =
               response
    end
  end
end
