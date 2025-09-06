defmodule LilliaCore.Access.Roles.Role.Create do
  @moduledoc false

  alias LilliaCore.Access.Roles.Role
  alias LilliaCore.Repo

  @doc false
  def call(attrs) when is_map(attrs) do
    attrs
    |> Role.changeset()
    |> Repo.insert()
  end
end
