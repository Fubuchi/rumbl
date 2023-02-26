defmodule Rumbl.Accounts do
  alias Rumbl.Repo
  alias Rumbl.Accounts.User

  def list_users(), do: Repo.all(User)

  def get_user(id), do: Repo.get(User, id)

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by(params), do: Repo.get_by(User, params)

  def change_user(user = %User{}), do: User.changeset(user, %{})

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def change_reg(user = %User{}, params), do: User.reg_changeset(user, params)

  def reg_user(attrs \\ %{}) do
    %User{}
    |> User.reg_changeset(attrs)
    |> Repo.insert()
  end

  def auth_by_username_pass(username, pass) do
    user = get_user_by(username: username)

    cond do
      user && Pbkdf2.verify_pass(pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
