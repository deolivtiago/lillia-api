defmodule LilliaCore.Access.Roles.Role.List do
  @moduledoc false

  alias LilliaCore.Access.Roles.Role
  alias LilliaCore.Repo

  @doc false
  def call, do: Repo.all(Role)
end
