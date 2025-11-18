defmodule LilliaCore.Registry.Persons.Person.Create do
  @moduledoc false

  alias LilliaCore.Registry.Persons.Person
  alias LilliaCore.Repo

  @doc false
  def call(attrs) when is_map(attrs) do
    attrs
    |> Person.changeset()
    |> Repo.insert()
  end
end
