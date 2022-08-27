defmodule Blogger.Posts.PutTest do
  use Blogger.DataCase, async: true
  import Blogger.Factory
  alias Blogger.Posts.Put
  alias Blogger.{Error, Post}

  describe "call/1" do
    test "when all params are valid, returns a valid changeset" do
      user = insert(:user)
      post = insert(:post, user_id: user.id)

      response = Put.call(%{"id" => post.id, "title" => "New Title", "content" => "New Content"})

      assert {:ok,
              %Post{
                content: "New Content",
                id: _id,
                title: "New Title",
                user: _user,
                user_id: _user_id
              }} = response
    end

    test "when there are some error, returns an invalid changeset" do
      response = Put.call(%{"id" => 999})

      assert {:error, %Error{message: "Post não existe", status: :not_found}} = response
    end
  end
end
