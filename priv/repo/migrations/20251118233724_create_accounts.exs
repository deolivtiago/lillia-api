defmodule LilliaCore.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :type, :integer
      add :is_group, :boolean, null: false
      # assets, liabilities, equity, revenue, expenses
      add :category, :integer, null: false

      add :number, :string, null: false
      add :title, :string, null: false

      add :hierarchy, :string, null: false
      add :parent_number, :string, null: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:accounts, [:number])
  end
end
