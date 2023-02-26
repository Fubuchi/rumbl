defmodule RumblWeb.SessionController do
  use RumblWeb, :controller

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User

  alias RumblWeb.Auth

  def new(conn, _), do: render(conn, "new.html")

  def create(
        conn,
        %{
          "session" => %{"username" => username, "password" => password}
        }
      ) do
    case Accounts.auth_by_username_pass(username, password) do
      {:ok, user = %User{}} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "Welcome back #{user.username}!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def test(conn, _) do
    conn
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
