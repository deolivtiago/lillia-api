defmodule LilliaWeb.UserJsonTest do
  use LilliaWeb.ConnCase, async: true

  import LilliaCore.Access.UserFixtures

  alias LilliaWeb.UserJSON

  setup do
    {:ok, user: build_user()}
  end

  describe "renders" do
    test "a list of users", %{user: user} do
      assert %{data: [user_data]} = UserJSON.index(%{users: [user]})

      assert user_data.id == user.id
      assert user_data.full_name == user.full_name
      assert user_data.email == user.email
      assert user_data.avatar_url == user.avatar_url
      assert user_data.role_id == user.role_id
      assert user_data.is_verified == user.verified?
    end

    test "a single user", %{user: user} do
      assert %{data: user_data} = UserJSON.show(%{user: user})

      assert user_data.id == user.id
      assert user_data.full_name == user.full_name
      assert user_data.email == user.email
      assert user_data.avatar_url == user.avatar_url
      assert user_data.role_id == user.role_id
      assert user_data.is_verified == user.verified?
    end
  end
end
