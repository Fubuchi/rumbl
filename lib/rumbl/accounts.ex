defmodule Rumbl.Accounts do
  alias Rumbl.Accounts.User

  def list_users() do
    [
      %User{id: "1", name: "José", username: "josevalim"},
      %User{id: "2", name: "Bruce", username: "redrapids"},
      %User{id: "3", name: "Chris", username: "chrismccord"}
    ]
  end

  def get_user(id) do
    list_users()
    |> Enum.find(&(&1.id == id))
  end

  def get_user_by(params) do
    list_users()
    |> Enum.find(fn user ->
      Enum.all?(params, fn {k, v} -> Map.get(user, k) == v end)
    end)
  end
end
