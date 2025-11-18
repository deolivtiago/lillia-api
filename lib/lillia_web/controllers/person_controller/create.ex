defmodule LilliaWeb.PersonController.Create do
  @moduledoc false

  import Ecto.Changeset

  alias LilliaCore.Registry.Persons

  @doc false
  def handle(params) do
    params
    |> validate_params()
    |> create_person()
  end

  defp validate_params(params) do
    types = %{full_name: :string, type: :string, short_name: :string, social_id: :string}
    optional = ~w(type short_name social_id)a

    cast({%{}, types}, params, Map.keys(types))
    |> validate_required(Enum.reject(Map.keys(types), &Enum.member?(optional, &1)))
    |> validate_length(:full_name, min: 2, max: 255)
    |> validate_length(:short_name, max: 255)
    |> validate_length(:social_id, max: 64)
    |> apply_action(:validate)
  end

  defp create_person({:ok, attrs}), do: Persons.create_person(attrs)
  defp create_person({:error, changeset}), do: {:error, changeset}
end
