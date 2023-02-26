defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User
  alias RumblWeb.Auth

  plug :auth when action in [:index, :show]

  def index(conn, _params) do
    Accounts.list_users()
    |> then(&render(conn, "index.html", users: &1))
  end

  def show(conn, %{"id" => id}) do
    id
    |> Accounts.get_user()
    |> then(&render(conn, "show.html", user: &1))
  end

  def new(conn, _params) do
    changeset = Accounts.change_reg(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_data}) do
    case Accounts.reg_user(user_data) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "#{user.name} created")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, changeset = %Ecto.Changeset{}} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp auth(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
