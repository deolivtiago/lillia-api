defmodule LilliaCore.Access.Emails.VerificationCodeTest do
  use ExUnit.Case, async: true

  import LilliaCore.Access.UserFixtures

  alias LilliaCore.Access.Emails.VerificationCode
  alias LilliaCore.Access.Users.User

  setup do
    {:ok, user: build_user()}
  end

  describe "new/3 returns" do
    test "returns an email for user verification", %{user: user} do
      code = User.new_verification_code(user)

      assert %Swoosh.Email{} = VerificationCode.new(user, code)
    end
  end
end
