defmodule LilliaWeb.UserController.Show do
  @moduledoc false
  import Ecto.Changeset

  alias LilliaCore.Access.Users

  def handle(params) do
    params
    |> validate_params()
    |> get_user()
  end

  defp validate_params(params) do
    types = %{id: :binary_id}

    cast({%{}, types}, params, Map.keys(types))
    |> validate_required(Map.keys(types))
    |> update_change(:id, &String.downcase/1)
    |> validate_format(:id, ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
    |> apply_action(:validate)
  end

  defp get_user({:ok, %{id: id}}), do: Users.get_user(:id, id)
  defp get_user({:error, changeset}), do: {:error, changeset}
end
