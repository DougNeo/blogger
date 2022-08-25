defmodule Blogger.Posts.GetTest do
  use Blogger.DataCase, async: true
  import Blogger.Factory
  alias Blogger.Post

  describe "all/0" do
    test "when there are users, returns the users" do
      insert_list(2, :post)

      response = Blogger.Posts.Get.all()

      assert {:ok, [%Blogger.Post{}, %Blogger.Post{}]} = response
    end

    test "when there are no posts, returns a an empty array" do
      response = Blogger.Posts.Get.all()

      assert {:error, %Blogger.Error{message: "Posts não existem", status: :not_found}} = response

      # assert {:ok, []} = response
    end
  end

  describe "by_id/1" do
    test "when id is valid, returns the post" do
      post = insert(:post)

      response = Blogger.Posts.Get.by_id(post.id)

      assert {:ok, post} = response
    end

    test "when id is not valid, error post not found" do
      response = Blogger.Posts.Get.by_id(999)

      assert {:error, %Blogger.Error{message: "Post não existe", status: :not_found}} = response
    end
  end

  describe "by_content_or_title/1" do
    test "when term is nil, returns all posts" do
      insert_list(2, :post)

      response = Blogger.Posts.Get.by_content_or_title(nil)

      assert {:ok, [%Blogger.Post{}, %Blogger.Post{}]} = response
    end

    test "when term is empty, returns all posts" do
      insert_list(2, :post)

      response = Blogger.Posts.Get.by_content_or_title("")

      assert {:ok, [%Blogger.Post{}, %Blogger.Post{}]} = response
    end

    test "when term is valid, returns the posts" do
      post = insert(:post)

      response = Blogger.Posts.Get.by_content_or_title(post.title)

      assert {:ok, [post]} = response
    end

    test "when term is not valid, returns an empty array" do
      response = Blogger.Posts.Get.by_content_or_title("term")

      assert {:ok, []} = response
    end
  end
end
