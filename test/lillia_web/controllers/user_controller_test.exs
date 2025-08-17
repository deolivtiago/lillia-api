defmodule LilliaWeb.UserControllerTest do
  use LilliaWeb.ConnCase, async: true

  import LilliaCore.Access.RoleFixtures
  import LilliaCore.Access.UserFixtures
  import LilliaCore.Access.TokenFixtures

  @id_not_found Ecto.UUID.generate()

  setup %{conn: conn} do
    conn
    |> put_req_header("accept", "application/json")
    |> then(&{:ok, conn: &1})
  end

  describe "index/2 returns" do
    setup [:put_user, :put_auth]

    test "success with a list of users", %{conn: conn, user: user} do
      conn = get(conn, ~p"/api/users")

      assert %{"data" => [user_data]} = json_response(conn, :ok)

      assert user_data["id"] == user.id
      assert user_data["full_name"] == user.full_name
      assert user_data["email"] == user.email
      assert user_data["avatar_url"] == user.avatar_url
      assert user_data["role_id"] == user.role_id
      assert user_data["is_verified"] == user.verified?
    end
  end

  describe "create/2 returns" do
    setup [:put_user, :put_auth]

    test "success when the user params are valid", %{conn: conn} do
      user_params = user_attrs(%{verified?: false})

      conn = post(conn, ~p"/api/users", user_params)

      assert %{"data" => user_data} = json_response(conn, :created)

      assert user_data["id"]
      assert user_data["full_name"] == user_params.full_name
      assert user_data["email"] == user_params.email
      assert user_data["avatar_url"] == user_params.avatar_url
      assert user_data["role_id"] == user_params.role_id
      assert user_data["is_verified"] == user_params.verified?
    end

    test "error when the user params are invalid", %{conn: conn} do
      user_params = %{email: "", full_name: nil, password: "?"}

      conn = post(conn, ~p"/api/users", user_params)

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["full_name"], "can't be blank")
      assert Enum.member?(errors["email"], "can't be blank")
      assert Enum.member?(errors["password"], "should be at least 6 character(s)")
    end
  end

  describe "show/2 returns" do
    setup [:put_user, :put_auth]

    test "success when the user id is found", %{conn: conn, user: user} do
      conn = get(conn, ~p"/api/users/#{user}")

      assert %{"data" => user_data} = json_response(conn, :ok)

      assert user_data["id"] == user.id
      assert user_data["full_name"] == user.full_name
      assert user_data["email"] == user.email
      assert user_data["avatar_url"] == user.avatar_url
      assert user_data["role_id"] == user.role_id
      assert user_data["is_verified"] == user.verified?
    end

    test "error when the user id has invalid format", %{conn: conn} do
      conn = get(conn, ~p"/api/users/invalid_id")

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "has invalid format")
    end

    test "error when the user id is not found", %{conn: conn} do
      conn = get(conn, ~p"/api/users/#{@id_not_found}")

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "not found")
    end
  end

  describe "update/2 returns" do
    setup [:put_user, :put_auth]

    test "success when the user params are valid", %{conn: conn, user: user} do
      user_params = user_attrs(%{password: nil})

      conn = put(conn, ~p"/api/users/#{user}", user_params)

      assert %{"data" => user_data} = json_response(conn, :ok)

      assert user_data["id"] == user.id
      assert user_data["full_name"] == user_params.full_name
      assert user_data["email"] == user_params.email
      assert user_data["avatar_url"] == user_params.avatar_url
      assert user_data["role_id"] == user_params.role_id
      assert user_data["is_verified"] == user_params.verified?
    end

    test "error when the user params are invalid", %{conn: conn, user: user} do
      user_params = %{email: "@@@", full_name: 1, password: "P455word!", role_id: "root"}

      conn = put(conn, ~p"/api/users/#{user}", user_params)

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["full_name"], "is invalid")
      assert Enum.member?(errors["email"], "has invalid format")
      assert Enum.member?(errors["password"], "can only be changed by resetting")
      assert Enum.member?(errors["role_id"], "is invalid")
    end
  end

  describe "delete/2 returns" do
    setup [:put_user, :put_auth]

    test "success when the user is found", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/users/#{user}")

      assert response(conn, :no_content)
    end

    test "error when the user id has invalid format", %{conn: conn} do
      conn = delete(conn, ~p"/api/users/1")

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "has invalid format")
    end

    test "error when the user is not found", %{conn: conn} do
      conn = delete(conn, ~p"/api/users/#{@id_not_found}")

      assert %{"errors" => errors} = json_response(conn, :unprocessable_entity)

      assert Enum.member?(errors["id"], "not found")
    end
  end

  defp put_user(_) do
    role_id =
      Map.new()
      |> Map.put(:permissions, ~w(GET:api/users POST:api/users PUT:api/users DELETE:api/users))
      |> insert_role()
      |> Map.get(:id)

    {:ok, user: insert_user(%{role_id: role_id})}
  end

  defp put_auth(%{user: user, conn: conn}) do
    token = insert_token(user, typ: :access) |> Map.get(:token)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
    |> then(&{:ok, conn: &1})
  end
end
