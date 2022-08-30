defmodule Blogger.Users.IndexTest do
  use Blogger.DataCase, async: true
  import Blogger.Factory

  alias Blogger.Users.Index
  alias Blogger.User

  describe "call/0" do
    test "when there are users, returns them" do
      insert_list(2, :user)

      response = Index.call()

      assert {:ok, [%User{}, %User{}]} = response
    end

    test "when there are no users, returns an empty array" do
      response = Index.call()

      assert {:ok, []} = response
    end
  end
end
