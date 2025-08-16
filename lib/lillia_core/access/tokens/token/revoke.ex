defmodule LilliaCore.Access.Tokens.Token.Revoke do
  @moduledoc false

  alias LilliaCore.Access.Tokens.Token
  alias LilliaCore.Repo

  @doc false
  def call(%Token{} = token) do
    with {:ok, token} <- Repo.delete(token) do
      token
      |> Repo.preload(user: :role)
      |> then(&{:ok, &1})
    end
  end
end
