defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  alias Rumbl.Accounts

  def index(conn, _params) do
    Accounts.list_users()
    |> then(&render(conn, "index.html", users: &1))
  end

  def show(conn, %{"id" => id}) do
    id
    |> Accounts.get_user()
    |> then(&render(conn, "show.html", user: &1))
  end
end
