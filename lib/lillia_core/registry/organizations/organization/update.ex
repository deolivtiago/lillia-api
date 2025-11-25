defmodule LilliaCore.Registry.Organizations.Organization.Update do
  @moduledoc false

  alias LilliaCore.Registry.Organizations.Organization
  alias LilliaCore.Repo

  @doc false
  def call(%Organization{} = organization, attrs) when is_map(attrs) do
    organization
    |> Organization.changeset(attrs)
    |> Repo.update()
  end
end
