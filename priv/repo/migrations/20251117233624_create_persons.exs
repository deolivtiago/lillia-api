defmodule LilliaCore.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :full_name, :string, null: false

      add :short_name, :string, null: false, default: ""
      add :social_id, :string, null: false, default: ""

      add :type, :integer, null: false, default: 0

      timestamps(type: :timestamptz)
    end

    create unique_index(:persons, [:social_id])
  end
end
