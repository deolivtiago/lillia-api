defmodule LilliaCore.Access.Roles.Role.Delete do
  @moduledoc false

  import Ecto.Changeset

  alias LilliaCore.Access.Roles.Role
  alias LilliaCore.Repo

  @fkey_opts [name: :users_role_id_fkey, message: "can't be deleted"]
  @delete_opts [stale_error_field: :id, stale_error_message: "not found"]

  @doc false
  def call(%Role{} = role) do
    role
    |> change()
    |> foreign_key_constraint(:id, @fkey_opts)
    |> Repo.delete(@delete_opts)
  end
end
