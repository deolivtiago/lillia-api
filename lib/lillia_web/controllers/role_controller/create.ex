defmodule LilliaWeb.RoleController.Create do
  @moduledoc false

  import Ecto.Changeset

  alias LilliaCore.Access.Roles

  @doc false
  def handle(params) do
    params
    |> validate_params()
    |> create_role()
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

  defp create_role({:ok, attrs}), do: Roles.create_role(attrs)
  defp create_role({:error, changeset}), do: {:error, changeset}
end
