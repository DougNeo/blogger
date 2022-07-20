defmodule Blogger.Posts.CreateTest do
  use Blogger.DataCase, async: true
  import Blogger.Factory

  describe "call/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:post_params)
      user = insert(:user)

      response = Blogger.Posts.Create.call(params, user)

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
      params = build(:post_params, %{title: "", content: ""})
      user = insert(:user)

      response = Blogger.Posts.Create.call(params, user)

      assert {:error,
              %Blogger.Error{
                message: %Ecto.Changeset{
                  action: :insert,
                  changes: %{},
                  errors: [
                    title: {"is required", [validation: :required]},
                    content: {"is required", [validation: :required]}
                  ],
                  valid?: false
                },
                status: :bad_request
              }} = response
    end
  end
end
