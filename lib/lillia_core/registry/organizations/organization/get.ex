defmodule LilliaCore.Registry.Organizations.Organization.Get do
  @moduledoc false

  import Ecto.Changeset

  alias LilliaCore.Registry.Organizations.Organization
  alias LilliaCore.Repo

  @doc false
  def call(:id, value) when is_binary(value) do
    case Repo.get_by(Organization, id: value) do
      %Organization{} = organization ->
        {:ok, organization}

      nil ->
        %Organization{}
        |> change()
        |> add_error(:id, "not found")
        |> then(&{:error, &1})
    end
  end
end
