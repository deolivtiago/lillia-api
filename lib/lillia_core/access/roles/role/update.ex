defmodule LilliaCore.Access.Roles.Role.Update do
  @moduledoc false

  alias LilliaCore.Access.Roles.Role
  alias LilliaCore.Repo

  @doc false
  def call(%Role{} = role, attrs) when is_map(attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end
end
