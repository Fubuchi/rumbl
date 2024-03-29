# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rumbl.Repo.insert!(%Rumbl.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rumbl.Repo
alias Rumbl.Accounts.User

# Repo.insert!(%User{
#   name: "José",
#   username: "josevalim"
# })

# Repo.insert!(%User{
#   name: "Bruce",
#   username: "redrapids"
# })

# Repo.insert!(%User{
#   name: "Chris",
#   username: "mccord"
# })

for u <- Repo.all(User) do
  Repo.update!(User.reg_changeset(u, %{password: "123456"}))
end
