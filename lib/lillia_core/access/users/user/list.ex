defmodule LilliaCore.Access.Users.User.List do
  @moduledoc false

  alias LilliaCore.Access.Users.User
  alias LilliaCore.Repo

  @doc false
  def call do
    User
    |> Repo.all()
    |> Repo.preload(:role)
  end
end
