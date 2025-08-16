defmodule LilliaCore.Access.Tokens.Token.List do
  @moduledoc false

  alias LilliaCore.Access.Tokens.Token
  alias LilliaCore.Repo

  @doc false
  def call do
    Token
    |> Repo.all()
    |> Repo.preload(user: :role)
  end
end
