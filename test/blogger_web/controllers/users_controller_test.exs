defmodule BloggerWeb.UsersControllerTest do
  use BloggerWeb.ConnCase, async: true
  import Blogger.Factory
  alias BloggerWeb.Auth.Guardian

  describe "create/2" do
    test "when all params are valid, create the user", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
      |> post(Routes.users_path(conn, :create, params))
      |> json_response(:created)

      assert %{"token" => _token} = response
    end

    test "when there is some error, return the error", %{conn: conn} do
      params = build(:user_params, email: nil)

      response =
        conn
      |> post(Routes.users_path(conn, :create, params))
      |> json_response(:bad_request)

      assert %{"message" => "\"email\" is required"} = response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      user = insert(:user)
      conn = Guardian.Plug.sign_in(conn, user)

      response =
        conn
        |> delete(Routes.users_path(conn, :destroy, %{"id" => user.id}))
        |> response(:no_content)

      assert response == ""
    end

    test "when the user is not found, return the error", %{conn: conn} do
      user_1 = insert(:user)
      user_2 = insert(:user)
      conn = Guardian.Plug.sign_in(conn, user_1)

      response =
        conn
      |> delete(Routes.users_path(conn, :destroy, %{"id" => user_2.id}))
      |> response(:not_found)

      assert response == "banana"
    end
  end

  describe "show/2" do
    test "when there is a user with the given id, returns the user", %{conn: conn} do
      user = insert(:user)
      conn = Guardian.Plug.sign_in(conn, user)

      response =
        conn
      |> get(Routes.users_path(conn, :show, user.id))
      |> json_response(:ok)

      assert response == %{"displayName" => "Fulano de Tal", "email" => "fulano-1@email.com", "id" => 1, "image" => "http://example.com/image.jpg"}
    end

    test "when the user is not given token, return the error", %{conn: conn} do
      user = insert(:user)

      response =
        conn
      |> get(Routes.users_path(conn, :show, user.id))
      |> response(:unauthorized)

      assert response == "{\"message\":\"Token não encontrado\"}"
    end
  end
end
