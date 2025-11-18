defmodule LilliaWeb.PersonJSON do
  @moduledoc false

  alias LilliaCore.Registry.Persons.Person

  @doc """
  Renders a list of persons
  """
  def index(%{persons: persons}), do: %{data: for(person <- persons, do: data(person))}

  @doc """
  Renders a single person
  """
  def show(%{person: person}), do: %{data: data(person)}

  defp data(%Person{} = person) do
    %{
      id: person.id,
      full_name: person.full_name,
      type: person.type,
      short_name: person.short_name,
      social_id: person.social_id
    }
  end
end
