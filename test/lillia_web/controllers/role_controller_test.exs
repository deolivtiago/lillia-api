defmodule LilliaWeb.RoleControllerTest do
  use LilliaWeb.ConnCase, async: true

  import LilliaCore.Access.RoleFixtures
  import LilliaCore.Access.UserFixtures
  import LilliaCore.Access.TokenFixtures

  setup %{conn: conn} do
    delete_roles()

    conn
    |> put_req_header("accept", "application/json")
    |> then(&{:ok, conn: &1})
  end

  describe "index/2 returns" do
    setup [:put_role, :put_auth]

    test "success with a list of roles", %{conn: conn, role: role} do
      conn = get(conn, ~p"/api/roles")

      assert %{"data" => [role_data]} = json_response(conn, :ok)

      assert role_data["id"] == role.id
      assert role_data["permissions"] == role.permissions
    end
  end

  describe "create/2 returns" do
    setup [:put_role, :put_auth]

    test "success when the role params are valid", %{conn: conn} do
      role_params = %{id: "wizard", permissions: ~w(GET:powerful/magic POST:powerful/magic)}

      conn = post(conn, ~p"/api/roles", role_params)

      assert %{"data" => role_data} = json_response(conn, :created)

      assert role_data["id"] == role_params.id
      assert role_data["permissions"] == role_params.permissions
    end

    test "error when the role params are invalid", %{conn: conn} do
      role_params = %{id: "", permissions: "INVALID.permission"}

      conn = post(conn, ~p"/api/roles", role_params)

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "can't be blank")
      assert Enum.member?(errors["permissions"], "is invalid")
    end
  end

  describe "show/2 returns" do
    setup [:put_role, :put_auth]

    test "success when the role id is found", %{conn: conn, role: role} do
      conn = get(conn, ~p"/api/roles/#{role}")

      assert %{"data" => role_data} = json_response(conn, :ok)

      assert role_data["id"] == role.id
      assert role_data["permissions"] == role.permissions
    end

    test "error when the user id has invalid format", %{conn: conn} do
      conn = get(conn, ~p"/api/roles/@@@")

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "has invalid format")
    end

    test "error when the user id is not found", %{conn: conn} do
      conn = get(conn, ~p"/api/roles/id_not_found")

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "not found")
    end
  end

  describe "update/2 returns" do
    setup [:put_role, :put_auth]

    test "success when the role params are valid", %{conn: conn, role: role} do
      role_params = %{id: "to_be_refuted", permissions: ~w(DELETE:valid/permission)}

      conn = put(conn, ~p"/api/roles/#{role}", role_params)

      assert %{"data" => role_data} = json_response(conn, :ok)

      assert role_data["id"] == role.id
      refute role_data["id"] == role_params.id
      assert role_data["permissions"] == role_params.permissions
    end

    test "error when the role params are invalid", %{conn: conn, role: role} do
      conn = put(conn, ~p"/api/roles/#{role}", %{})

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["permissions"], "can't be blank")
    end
  end

  describe "delete/2 returns" do
    setup [:put_role, :put_auth]

    test "success when the role is found", %{conn: conn} do
      role = insert_role(%{id: "to_be_deleted"})

      conn = delete(conn, ~p"/api/roles/#{role}")

      assert response(conn, :no_content)
    end

    test "error when the role id has invalid format", %{conn: conn} do
      conn = delete(conn, ~p"/api/roles/@@@")

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "has invalid format")
    end

    test "error when the role is not found", %{conn: conn} do
      conn = delete(conn, ~p"/api/roles/id_not_found")

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "not found")
    end
  end

  defp put_role(_) do
    Map.new()
    |> Map.put(:permissions, ~w(GET:api/roles POST:api/roles PUT:api/roles DELETE:api/roles))
    |> insert_role()
    |> then(&{:ok, role: &1})
  end

  defp put_auth(%{conn: conn, role: role}) do
    user = Map.new() |> Map.put(:role_id, role.id) |> insert_user()
    token = insert_token(user, typ: :access) |> Map.get(:token)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
    |> then(&{:ok, conn: &1})
  end
end
