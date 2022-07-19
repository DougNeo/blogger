defmodule Blogger.Users.DeleteTest do
  use Blogger.DataCase, async: true
  import Blogger.Factory
  alias Blogger.{Repo, User}

  describe "call/1" do
    test "when id is valid, delete the user" do
      user = insert(:user)

      response = Blogger.Users.Delete.call(user.id)

      assert {:ok, _deleted_user} = response

      refute Repo.get(User, user.id)
    end

    test "when id is not valid, error user not found" do
      response = Blogger.Users.Delete.call(999)

      assert {:error, %Blogger.Error{message: "User not found", status: :not_found}} = response

      refute Repo.get(User, 999)
    end
  end
end
