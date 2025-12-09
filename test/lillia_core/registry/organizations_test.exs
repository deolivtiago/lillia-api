defmodule LilliaCore.Registry.OrganizationsTest do
  use LilliaCore.DataCase, async: true

  import LilliaCore.Registry.OrganizationFixtures

  alias Ecto.Changeset
  alias LilliaCore.Registry.Organizations
  alias LilliaCore.Registry.Organizations.Organization

  setup do
    {:ok, attrs: organization_attrs()}
  end

  describe "list_organizations/0" do
    test "returns all organizations" do
      assert [] == Organizations.list_organizations()

      organization = insert_organization()

      assert [organization] == Organizations.list_organizations()
    end
  end

  describe "get_organization/3 returns" do
    setup [:put_organization]

    test "ok when the organization_id is found", %{organization: organization} do
      assert {:ok, organization} == Organizations.get_organization(:id, organization.id)
    end

    test "error when the organization_id is not found" do
      id = Ecto.UUID.generate()

      assert {:error, changeset} = Organizations.get_organization(:id, id)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.id, "not found")
    end

    test "ok when the social_id is found", %{organization: organization} do
      assert {:ok, organization} ==
               Organizations.get_organization(:social_id, organization.social_id)
    end

    test "error when the social_id is not found" do
      assert {:error, changeset} = Organizations.get_organization(:social_id, "00000000000100")

      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.social_id, "not found")
    end
  end

  describe "create_organization/1 returns" do
    test "ok when the organization attrs are valid", %{attrs: attrs} do
      assert {:ok, %Organization{} = organization} = Organizations.create_organization(attrs)

      assert organization.full_name == attrs.full_name
      assert organization.short_name == attrs.short_name
      assert organization.social_id == attrs.social_id
      assert organization.avatar_url == attrs.avatar_url
    end

    test "error when the organization attrs are invalid" do
      attrs = %{social_id: :invalid, full_name: nil, short_name: 1, avatar_url: :invalid}

      assert {:error, changeset} = Organizations.create_organization(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.full_name, "can't be blank")
      assert Enum.member?(errors.short_name, "is invalid")
      assert Enum.member?(errors.social_id, "is invalid")
      assert Enum.member?(errors.avatar_url, "is invalid")
    end

    test "error when the social_id already exists", %{attrs: attrs} do
      attrs = Map.put(attrs, :social_id, insert_organization().social_id)

      assert {:error, changeset} = Organizations.create_organization(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.social_id, "has already been taken")
    end
  end

  describe "update_organization/2 returns" do
    setup [:put_organization]

    test "ok when the organization attrs are valid", %{
      organization: %{id: id} = organization,
      attrs: attrs
    } do
      assert {:ok, %Organization{id: ^id} = organization} =
               Organizations.update_organization(organization, attrs)

      assert attrs.id != organization.id
      assert attrs.full_name == organization.full_name
      assert attrs.short_name == organization.short_name
      assert attrs.social_id == organization.social_id
      assert attrs.avatar_url == organization.avatar_url
    end

    test "error when the organization attrs are invalid", %{organization: organization} do
      invalid_attrs = %{social_id: :invalid, full_name: nil, short_name: 0, avatar_url: 1}

      assert {:error, changeset} = Organizations.update_organization(organization, invalid_attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.full_name, "can't be blank")
      assert Enum.member?(errors.short_name, "is invalid")
      assert Enum.member?(errors.social_id, "is invalid")
      assert Enum.member?(errors.avatar_url, "is invalid")
    end
  end

  describe "delete_organization/1 returns" do
    setup [:put_organization]

    test "ok when the organization is deleted", %{organization: organization} do
      assert {:ok, %Organization{}} = Organizations.delete_organization(organization)

      assert {:error, changeset} = Organizations.delete_organization(organization)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert Enum.member?(errors.id, "not found")
    end
  end

  defp put_organization(_) do
    {:ok, organization: insert_organization()}
  end
end
