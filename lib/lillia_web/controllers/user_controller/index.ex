defmodule LilliaWeb.UserController.Index do
  @moduledoc false

  alias LilliaCore.Access.Users

  @doc false
  def handle(_params), do: Users.list_users()
end
