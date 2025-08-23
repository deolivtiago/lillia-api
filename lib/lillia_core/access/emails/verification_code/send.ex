defmodule LilliaCore.Access.Emails.VerificationCode.Send do
  @moduledoc false

  alias LilliaCore.Access.Emails
  alias LilliaCore.Access.Users.User
  alias LilliaCore.Mailer

  @doc false
  def call(%User{} = user, code) do
    user
    |> Emails.VerificationCode.new(code)
    |> Mailer.send_email()
  end
end
