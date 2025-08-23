defmodule LilliaCore.Access.Users.User.Verify do
  @moduledoc false

  alias LilliaCore.Access.Emails
  alias LilliaCore.Access.Users.User

  @doc false
  def call(%User{} = user) do
    user
    |> User.new_verification_code()
    |> then(&Emails.send_verification_code(user, &1))
  end
end
