defmodule Blogger.PostTest do
  use Blogger.DataCase, async: true
  import Blogger.Factory

  alias Blogger.Post
  alias Ecto.Changeset

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:post_params)

      response = Post.changeset(params)

      assert %Changeset{
               changes: %{
                 title: "Post Title",
                 content: "Post Body"
               },
               valid?: true
             } = response
    end
  end
end
