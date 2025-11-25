defmodule LilliaCore.Registry.Organizations.Organization.Create do
  @moduledoc false

  alias LilliaCore.Registry.Organizations.Organization
  alias LilliaCore.Repo

  @doc false
  def call(attrs) when is_map(attrs) do
    attrs
    |> Organization.changeset()
    |> Repo.insert()
  end
end
