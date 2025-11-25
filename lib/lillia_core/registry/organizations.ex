defmodule LilliaCore.Registry.Organizations do
  @moduledoc """
  `Registry.Organizations` context
  """

  alias LilliaCore.Registry.Organizations.Organization

  @doc ~S"""
  Lists all `Organization`s

  ## Examples

      iex> list_organizations()
      [%Organization{}, ...]

  """
  defdelegate list_organizations, to: Organization.List, as: :call

  @doc ~S"""
  Gets an `Organization`

  ## Examples

      iex> get_organization(field, value)
      {:ok, %Organization{}}

      iex> get_organization(field, bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_organization(field, value), to: Organization.Get, as: :call

  @doc ~S"""
  Creates an `Organization`

  ## Examples

      iex> create_organization(attrs)
      {:ok, %Organization{}}

      iex> create_organization(bad_attrs)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_organization(attrs), to: Organization.Create, as: :call

  @doc ~S"""
  Updates an `Organization`

  ## Examples

      iex> update_organization(organization, attrs)
      {:ok, %Organization{}}

      iex> update_organization(organization, bad_attrs)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_organization(organization, attrs), to: Organization.Update, as: :call

  @doc ~S"""
  Deletes an `Organization`

  ## Examples

      iex> delete_organization(organization)
      {:ok, %Organization{}}

      iex> delete_organization(bad_organization)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_organization(organization), to: Organization.Delete, as: :call
end
