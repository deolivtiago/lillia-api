defmodule LilliaCore.Registry.Organizations.OrganizationTest do
  use LilliaCore.DataCase, async: true

  import LilliaCore.Registry.OrganizationFixtures

  alias Ecto.Changeset
  alias LilliaCore.Registry.Organizations.Organization

  setup do
    {:ok, attrs: organization_attrs()}
  end

  describe "changeset/1 returns a valid changeset" do
    test "when full_name is valid", %{attrs: attrs} do
      changeset = Organization.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert Changeset.get_field(changeset, :full_name) == attrs.full_name
    end

    test "when short_name is valid", %{attrs: attrs} do
      changeset = Organization.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert Changeset.get_field(changeset, :short_name) == attrs.short_name

      attrs = Map.delete(attrs, :short_name)
      assert %Changeset{valid?: true} = Organization.changeset(attrs)
    end

    test "when social_id is valid", %{attrs: attrs} do
      changeset = Organization.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert Changeset.get_field(changeset, :social_id) == attrs.social_id

      attrs = Map.delete(attrs, :social_id)
      assert %Changeset{valid?: true} = Organization.changeset(attrs)
    end

    test "when avatar_url is valid", %{attrs: attrs} do
      attrs = Map.put(attrs, :avatar_url, String.upcase(attrs.avatar_url))

      changeset = Organization.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert Changeset.get_field(changeset, :avatar_url) == String.downcase(attrs.avatar_url)
    end
  end

  describe "changeset/1 returns an invalid changeset" do
    test "when full_name is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :full_name, "?")

      changeset = Organization.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.full_name, "should be at least 2 character(s)")
    end

    test "when full_name is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :full_name, "")

      changeset = Organization.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.full_name, "can't be blank")
    end
  end

  describe "changeset/2 returns a valid changeset" do
    setup [:put_organization]

    test "when full_name is valid", %{attrs: attrs, organization: organization} do
      changeset = Organization.changeset(organization, attrs)

      assert %Changeset{valid?: true} = changeset
      assert Changeset.get_field(changeset, :full_name) == attrs.full_name
    end

    test "when short_name is valid", %{attrs: attrs, organization: organization} do
      changeset = Organization.changeset(organization, attrs)

      assert %Changeset{valid?: true} = changeset
      assert Changeset.get_field(changeset, :short_name) == attrs.short_name
    end

    test "when social_id is valid", %{attrs: attrs, organization: organization} do
      changeset = Organization.changeset(organization, attrs)

      assert %Changeset{valid?: true} = changeset
      assert Changeset.get_field(changeset, :social_id) == attrs.social_id

      attrs = Map.delete(attrs, :social_id)
      assert %Changeset{valid?: true} = Organization.changeset(organization, attrs)
    end

    test "when avatar_url is valid", %{attrs: attrs, organization: organization} do
      attrs = Map.put(attrs, :avatar_url, String.upcase(attrs.avatar_url))

      changeset = Organization.changeset(organization, attrs)

      assert %Changeset{valid?: true} = changeset
      assert Changeset.get_field(changeset, :avatar_url) == String.downcase(attrs.avatar_url)
    end
  end

  describe "changeset/2 returns an invalid changeset" do
    setup [:put_organization]

    test "when full_name is too short", %{attrs: attrs, organization: organization} do
      attrs = Map.put(attrs, :full_name, "?")

      changeset = Organization.changeset(organization, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.full_name, "should be at least 2 character(s)")
    end

    test "when full_name is empty", %{attrs: attrs, organization: organization} do
      attrs = Map.put(attrs, :full_name, "")

      changeset = Organization.changeset(organization, attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.full_name, "can't be blank")
    end
  end

  defp put_organization(_) do
    {:ok, organization: build_organization()}
  end
end
