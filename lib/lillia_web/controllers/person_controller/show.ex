defmodule LilliaWeb.PersonController.Show do
  @moduledoc false

  import Ecto.Changeset

  alias LilliaCore.Registry.Persons

  def handle(params) do
    params
    |> validate_params()
    |> get_person()
  end

  defp validate_params(params) do
    types = %{id: :binary_id}

    cast({%{}, types}, params, Map.keys(types))
    |> validate_required(Map.keys(types))
    |> update_change(:id, &String.downcase/1)
    |> validate_format(:id, ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
    |> apply_action(:validate)
  end

  defp get_person({:ok, %{id: id}}), do: Persons.get_person(:id, id)
  defp get_person({:error, changeset}), do: {:error, changeset}
end
