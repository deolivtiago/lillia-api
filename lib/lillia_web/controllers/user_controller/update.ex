defmodule LilliaWeb.UserController.Update do
  @moduledoc false

  import Ecto.Changeset

  alias LilliaCore.Access.Users

  @doc false
  def handle(params) do
    params
    |> validate_params()
    |> get_user()
    |> update_user()
  end

  defp validate_params(params) do
    types = %{
      id: :binary_id,
      full_name: :string,
      avatar_url: :string,
      email: :string,
      password: :string,
      role_id: :string
    }

    cast({%{}, types}, params, Map.keys(types))
    |> validate_required(~w(id)a)
    |> update_change(:id, &String.downcase/1)
    |> validate_format(:id, ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
    |> validate_length(:full_name, min: 2, max: 255)
    |> update_change(:email, &String.downcase/1)
    |> validate_length(:email, min: 3, max: 160)
    |> validate_format(:email, ~r/^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/)
    |> validate_length(:password, max: 0, message: "can only be changed by resetting")
    |> validate_format(:role_id, ~r/^[a-zA-Z0-9_]+$/)
    |> validate_length(:role_id, max: 64)
    |> validate_exclusion(:role_id, ~w(root), message: "is invalid")
    |> update_change(:avatar_url, &String.downcase/1)
    |> validate_length(:avatar_url, max: 255)
    |> apply_action(:validate)
  end

  defp get_user({:ok, %{id: id} = attrs}) do
    with {:ok, user} <- Users.get_user(:id, id) do
      {:ok, %{user: user, attrs: attrs}}
    end
  end

  defp get_user({:error, changeset}), do: {:error, changeset}

  defp update_user({:ok, %{user: user, attrs: attrs}}), do: Users.update_user(user, attrs)
  defp update_user({:error, changeset}), do: {:error, changeset}
end
