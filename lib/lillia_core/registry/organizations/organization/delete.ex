defmodule LilliaCore.Registry.Organizations.Organization.Delete do
  @moduledoc false

  alias LilliaCore.Registry.Organizations.Organization
  alias LilliaCore.Repo

  @delete_opts [stale_error_field: :id, stale_error_message: "not found"]

  @doc false
  def call(%Organization{} = organization), do: Repo.delete(organization, @delete_opts)
end
