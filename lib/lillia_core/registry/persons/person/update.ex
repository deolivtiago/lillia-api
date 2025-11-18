defmodule LilliaCore.Registry.Persons.Person.Update do
  @moduledoc false

  alias LilliaCore.Registry.Persons.Person
  alias LilliaCore.Repo

  @doc false
  def call(%Person{} = person, attrs) when is_map(attrs) do
    person
    |> Person.changeset(attrs)
    |> Repo.update()
  end
end
