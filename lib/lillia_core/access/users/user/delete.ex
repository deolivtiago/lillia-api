defmodule LilliaCore.Access.Users.User.Delete do
  @moduledoc false

  alias LilliaCore.Access.Users.User
  alias LilliaCore.Repo

  @opts [stale_error_field: :id, stale_error_message: "not found"]

  @doc false
  def call(%User{} = user), do: Repo.delete(user, @opts)
end
