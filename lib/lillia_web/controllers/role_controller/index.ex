defmodule LilliaWeb.RoleController.Index do
  @moduledoc false

  alias LilliaCore.Access.Roles

  @doc false
  def handle(_params), do: Roles.list_roles()
end
