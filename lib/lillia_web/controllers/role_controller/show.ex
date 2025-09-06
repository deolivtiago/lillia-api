defmodule LilliaWeb.RoleController.Show do
  @moduledoc false
  import Ecto.Changeset

  alias LilliaCore.Access.Roles

  def handle(params) do
    params
    |> validate_params()
    |> get_role()
  end

  defp validate_params(params) do
    types = %{id: :string}

    cast({%{}, types}, params, Map.keys(types))
    |> validate_required(Map.keys(types))
    |> validate_format(:id, ~r/^[a-zA-Z0-9_]+$/)
    |> validate_length(:id, max: 64)
    |> validate_exclusion(:id, ~w(root), message: "is invalid")
    |> apply_action(:validate)
  end

  defp get_role({:ok, %{id: id}}), do: Roles.get_role(:id, id)
  defp get_role({:error, changeset}), do: {:error, changeset}
end
