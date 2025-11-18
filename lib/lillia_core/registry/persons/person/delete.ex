defmodule LilliaCore.Registry.Persons.Person.Delete do
  @moduledoc false

  import Ecto.Changeset

  alias LilliaCore.Registry.Persons.Person
  alias LilliaCore.Repo

  @fkey_opts [name: :users_person_id_fkey, message: "can't be deleted"]
  @delete_opts [stale_error_field: :id, stale_error_message: "not found"]

  @doc false
  def call(%Person{} = person) do
    person
    |> change()
    |> foreign_key_constraint(:id, @fkey_opts)
    |> Repo.delete(@delete_opts)
  end
end
