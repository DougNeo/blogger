defmodule Blogger.Posts.DeleteTest do
  use Blogger.DataCase, async: true
  import Blogger.Factory

  describe "call/1" do
    test "when all params are valid, returns a valid changeset" do
      user = insert(:user)
      post = insert(:post, user_id: user.id)

      response = Blogger.Posts.Delete.call(post.id)

      assert {:ok,
               %Blogger.Post{
                 content: "Post Body",
                 id: _id,
                 title: "Post Title",
                 user: _user,
                 user_id: _user_id
               }} = response
    end

    test "when there are some error, returns an invalid changeset" do

      response = Blogger.Posts.Delete.call(999)

      assert {:error, %Blogger.Error{message: "Post not found", status: :not_found}} = response
    end
  end
end
