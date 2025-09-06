defmodule LilliaWeb.RoleController do
  @moduledoc false

  use LilliaWeb, :controller

  alias LilliaWeb.RoleController.Create
  alias LilliaWeb.RoleController.Delete
  alias LilliaWeb.RoleController.Index
  alias LilliaWeb.RoleController.Show
  alias LilliaWeb.RoleController.Update

  action_fallback LilliaWeb.FallbackController

  @doc false
  def index(conn, params) do
    roles = Index.handle(params)

    render(conn, :index, roles: roles)
  end

  @doc false
  def create(conn, params) do
    with {:ok, role} <- Create.handle(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/roles/#{role}")
      |> render(:show, role: role)
    end
  end

  @doc false
  def show(conn, params) do
    with {:ok, role} <- Show.handle(params) do
      render(conn, :show, role: role)
    end
  end

  @doc false
  def update(conn, params) do
    with {:ok, role} <- Update.handle(params) do
      render(conn, :show, role: role)
    end
  end

  @doc false
  def delete(conn, params) do
    with {:ok, _role} <- Delete.handle(params) do
      send_resp(conn, :no_content, "")
    end
  end
end
