defmodule BloggerWeb.Auth.GuardianTest do
  use BloggerWeb.ConnCase, async: true
  import Blogger.Factory
  alias BloggerWeb.Auth.Guardian

  setup %{conn: conn} = config do
    cond do
      config[:login] ->
        user = insert(:user)
        signed_conn = Guardian.Plug.sign_in(conn, user)
        {:ok, conn: signed_conn}
      true ->
        :ok
    end
  end

  @tag :login
  test "shows page only when logged in", %{conn: conn} do
    conn = get(conn, Routes.users_path(conn, :index))
    assert json_response(conn, 200)
  end
end
