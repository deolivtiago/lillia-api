defmodule LilliaCore.Registry.OrganizationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LilliaCore.Registry.Organizations` context.
  """

  alias LilliaCore.Registry.Organizations.Organization
  alias LilliaCore.Repo

  @doc """
  Generate fake `Organization` attrs

  ## Examples

      iex> organization_attrs(%{field: value})
      %{field: value, ...}

  """
  def organization_attrs(attrs \\ %{}) do
    full_name = Faker.Company.name()

    Map.new()
    |> Map.put(:id, Faker.UUID.v4())
    |> Map.put(:full_name, full_name)
    |> Map.put(:short_name, String.split(full_name) |> List.first())
    |> Map.put(:social_id, Faker.UUID.v4())
    |> Map.put(:avatar_url, Faker.Internet.image_url())
    |> Map.put(:inserted_at, DateTime.add(DateTime.utc_now(), Enum.random(-90..-1), :day))
    |> Map.put(:updated_at, DateTime.add(DateTime.utc_now(), Enum.random(-90..-1), :day))
    |> Map.merge(attrs)
  end

  @doc """
  Builds a fake `Organization`

  ## Examples

      iex> build_organization(%{field: value})
      %Organization{field: value, ...}

  """
  def build_organization(attrs \\ %{}) do
    attrs
    |> organization_attrs()
    |> Organization.changeset()
    |> Ecto.Changeset.apply_action!(nil)
  end

  @doc """
  Inserts a fake `Organization`

  ## Examples

      iex> insert_organization(%{field: value})
      %Organization{field: value, ...}

  """
  def insert_organization(attrs \\ %{}) do
    attrs
    |> organization_attrs()
    |> Organization.changeset()
    |> Repo.insert!()
  end
end
