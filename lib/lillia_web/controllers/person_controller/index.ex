defmodule LilliaWeb.PersonController.Index do
  @moduledoc false

  alias LilliaCore.Registry.Persons

  @doc false
  def handle(_params), do: Persons.list_persons()
end
