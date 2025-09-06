defmodule LilliaWeb.RoleJsonTest do
  use LilliaWeb.ConnCase, async: true

  import LilliaCore.Access.RoleFixtures

  alias LilliaWeb.RoleJSON

  setup do
    {:ok, role: build_role()}
  end

  describe "renders" do
    test "a list of roles", %{role: role} do
      assert %{data: [role_data]} = RoleJSON.index(%{roles: [role]})

      assert role_data.id == role.id
      assert role_data.permissions == role.permissions
    end

    test "a single role", %{role: role} do
      assert %{data: role_data} = RoleJSON.show(%{role: role})

      assert role_data.id == role.id
      assert role_data.permissions == role.permissions
    end
  end
end
