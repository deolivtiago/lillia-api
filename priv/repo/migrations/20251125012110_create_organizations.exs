defmodule LilliaCore.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :full_name, :string, null: false
      add :short_name, :string, null: false, default: ""

      add :social_id, :string, null: false, default: ""
      add :avatar_url, :string, null: false, default: ""

      timestamps(type: :utc_datetime)
    end

    create unique_index(:organizations, [:social_id])
  end
end
