defmodule LilliaCore.Registry.Persons.Person.List do
  @moduledoc false

  alias LilliaCore.Registry.Persons.Person
  alias LilliaCore.Repo

  @doc false
  def call, do: Repo.all(Person)
end
