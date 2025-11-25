defmodule LilliaCore.Accounting.Coa.Account do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "accounts" do
    field :type, Ecto.Enum, values: [debit: 0, credit: 1], default: :debit
    field :is_group, :boolean, default: false

    field :category, Ecto.Enum,
      values: [assets: 0, liabilities: 1, equity: 2, revenue: 3, expenses: 4],
      default: :assets

    field :number, :string
    field :title, :string

    field :hierarchy, :string
    field :parent_number, :string

    field :type, Ecto.Enum, values: [juridical: 0, natural: 1, other: 2], default: :juridical

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(person \\ %__MODULE__{}, attrs) when is_map(attrs) do
    required_attrs = ~w(full_name)a
    optional_attrs = ~w(type short_name social_id)a

    person
    |> cast(attrs, required_attrs ++ optional_attrs)
    |> validate_required(required_attrs)
    |> unique_constraint(:id, name: :persons_pkey)
    |> validate_length(:full_name, min: 2, max: 255)
    |> validate_length(:short_name, max: 255)
    |> unique_constraint(:social_id)
    |> validate_length(:social_id, max: 64)
  end
end
