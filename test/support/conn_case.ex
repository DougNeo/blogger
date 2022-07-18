defmodule BloggerWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import BloggerWeb.ConnCase

      alias BloggerWeb.Router.Helpers, as: Routes

      @endpoint BloggerWeb.Endpoint
    end
  end

  setup tags do
    Blogger.DataCase.setup_sandbox(tags)
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
