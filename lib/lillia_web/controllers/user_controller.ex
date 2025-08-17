defmodule LilliaWeb.UserController do
  @moduledoc false

  use LilliaWeb, :controller

  alias LilliaWeb.UserController.Create
  alias LilliaWeb.UserController.Delete
  alias LilliaWeb.UserController.Index
  alias LilliaWeb.UserController.Show
  alias LilliaWeb.UserController.Update

  action_fallback LilliaWeb.FallbackController

  @doc false
  def index(conn, params) do
    users = Index.handle(params)

    render(conn, :index, users: users)
  end

  @doc false
  def create(conn, params) do
    with {:ok, user} <- Create.handle(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  @doc false
  def show(conn, params) do
    with {:ok, user} <- Show.handle(params) do
      render(conn, :show, user: user)
    end
  end

  @doc false
  def update(conn, params) do
    with {:ok, user} <- Update.handle(params) do
      render(conn, :show, user: user)
    end
  end

  @doc false
  def delete(conn, params) do
    with {:ok, _user} <- Delete.handle(params) do
      send_resp(conn, :no_content, "")
    end
  end
end
