defmodule LilliaCore.Registry.Persons do
  @moduledoc """
  `Registry.Persons` context
  """

  alias LilliaCore.Registry.Persons.Person

  @doc ~S"""
  Lists all `Person`s

  ## Examples

      iex> list_persons()
      [%Person{}, ...]

  """
  defdelegate list_persons, to: Person.List, as: :call

  @doc ~S"""
  Gets a `Person`

  ## Examples

      iex> get_person(field, value)
      {:ok, %Person{}}

      iex> get_person(field, bad_value)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate get_person(field, value), to: Person.Get, as: :call

  @doc ~S"""
  Creates a `Person`

  ## Examples

      iex> create_person(attrs)
      {:ok, %Person{}}

      iex> create_person(bad_attrs)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate create_person(attrs), to: Person.Create, as: :call

  @doc ~S"""
  Updates a `Person`

  ## Examples

      iex> update_person(person, attrs)
      {:ok, %Person{}}

      iex> update_person(person, bad_attrs)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate update_person(person, attrs), to: Person.Update, as: :call

  @doc ~S"""
  Deletes a `Person`

  ## Examples

      iex> delete_person(person)
      {:ok, %Person{}}

      iex> delete_person(bad_person)
      {:error, %Ecto.Changeset{}}

  """
  defdelegate delete_person(person), to: Person.Delete, as: :call
end
