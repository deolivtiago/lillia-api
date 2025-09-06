defmodule LilliaWeb.RoleController.Update do
  @moduledoc false

  import Ecto.Changeset

  alias LilliaCore.Access.Roles

  @doc false
  def handle(params) do
    params
    |> validate_params()
    |> get_role()
    |> update_role()
  end

  defp validate_params(params) do
    types = %{id: :string, permissions: {:array, :string}}

    cast({%{}, types}, params, Map.keys(types))
    |> validate_required(Map.keys(types))
    |> validate_format(:id, ~r/^[a-zA-Z0-9_]+$/)
    |> validate_length(:id, max: 64)
    |> validate_exclusion(:id, ~w(root), message: "is invalid")
    |> apply_action(:validate)
  end

  defp get_role({:ok, %{id: id} = attrs}) do
    with {:ok, role} <- Roles.get_role(:id, id) do
      {:ok, %{role: role, attrs: attrs}}
    end
  end

  defp get_role({:error, changeset}), do: {:error, changeset}

  defp update_role({:ok, %{role: role, attrs: attrs}}), do: Roles.update_role(role, attrs)
  defp update_role({:error, changeset}), do: {:error, changeset}
end
