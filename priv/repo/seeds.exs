# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LilliaCore.Repo.insert!(%LilliaCore.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

now = DateTime.utc_now(:second)

LilliaCore.Repo.insert_all(LilliaCore.Access.Roles.Role, [
  %{id: "user", inserted_at: now, updated_at: now}
])
