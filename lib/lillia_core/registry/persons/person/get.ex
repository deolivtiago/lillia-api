defmodule LilliaCore.Registry.Persons.Person.Get do
  @moduledoc false

  import Ecto.Changeset

  alias LilliaCore.Registry.Persons.Person
  alias LilliaCore.Repo

  @doc false
  def call(:id, value) when is_binary(value) do
    case Repo.get_by(Person, id: value) do
      %Person{} = person ->
        {:ok, person}

      nil ->
        %Person{}
        |> change()
        |> add_error(:id, "not found")
        |> then(&{:error, &1})
    end
  end
end
