defmodule LilliaWeb.RoleJSON do
  @moduledoc false

  alias LilliaCore.Access.Roles.Role

  @doc """
  Renders a list of roles
  """
  def index(%{roles: roles}), do: %{data: for(role <- roles, do: data(role))}

  @doc """
  Renders a single role
  """
  def show(%{role: role}), do: %{data: data(role)}

  defp data(%Role{} = role) do
    %{
      id: role.id,
      permissions: role.permissions
    }
  end
end
