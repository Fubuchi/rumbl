defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User

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
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_data}) do
    case Accounts.create_user(user_data) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, changeset = %Ecto.Changeset{}} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
