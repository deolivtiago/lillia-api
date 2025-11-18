defmodule LilliaWeb.PersonController.Update do
  @moduledoc false

  import Ecto.Changeset

  alias LilliaCore.Registry.Persons

  @doc false
  def handle(params) do
    params
    |> validate_params()
    |> get_person()
    |> update_person()
  end

  defp validate_params(params) do
    types = %{
      id: :string,
      full_name: :string,
      type: :string,
      short_name: :string,
      social_id: :string
    }

    cast({%{}, types}, params, Map.keys(types))
    |> validate_required(~w(id)a)
    |> update_change(:id, &String.downcase/1)
    |> validate_format(:id, ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
    |> validate_length(:full_name, min: 2, max: 255)
    |> validate_length(:short_name, max: 255)
    |> validate_length(:social_id, max: 64)
    |> apply_action(:validate)
  end

  defp get_person({:ok, %{id: id} = attrs}) do
    with {:ok, person} <- Persons.get_person(:id, id) do
      {:ok, %{person: person, attrs: attrs}}
    end
  end

  defp get_person({:error, changeset}), do: {:error, changeset}

  defp update_person({:ok, %{person: person, attrs: attrs}}),
    do: Persons.update_person(person, attrs)

  defp update_person({:error, changeset}), do: {:error, changeset}
end
