defmodule LilliaCore.Registry.Organizations.Organization do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "organizations" do
    field :full_name, :string
    field :short_name, :string, default: ""

    field :social_id, :string, default: ""
    field :avatar_url, :string, default: ""

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(organization \\ %__MODULE__{}, attrs) when is_map(attrs) do
    required_attrs = ~w(full_name)a
    optional_attrs = ~w(short_name social_id avatar_url)a

    organization
    |> cast(attrs, required_attrs ++ optional_attrs)
    |> validate_required(required_attrs)
    |> unique_constraint(:id, name: :organizations_pkey)
    |> validate_length(:full_name, min: 2, max: 255)
    |> validate_length(:short_name, max: 255)
    |> unique_constraint(:social_id)
    |> validate_length(:social_id, max: 255)
    |> update_change(:avatar_url, &String.downcase/1)
    |> validate_length(:avatar_url, max: 255)
  end
end
