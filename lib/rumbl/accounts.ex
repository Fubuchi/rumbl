defmodule Rumbl.Accounts do
  alias Rumbl.Repo
  alias Rumbl.Accounts.User

  def list_users(), do: Repo.all(User)

  def get_user(id), do: Repo.get(User, id)

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by(params), do: Repo.get(User, params)

  def change_user(user = %User{}), do: User.changeset(user, %{})

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
