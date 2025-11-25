defmodule LilliaCore.Registry.Organizations.Organization.List do
  @moduledoc false

  alias LilliaCore.Registry.Organizations.Organization
  alias LilliaCore.Repo

  @doc false
  def call, do: Repo.all(Organization)
end
