defmodule LilliaWeb.PersonController do
  @moduledoc false

  use LilliaWeb, :controller

  alias LilliaWeb.PersonController.Create
  alias LilliaWeb.PersonController.Delete
  alias LilliaWeb.PersonController.Index
  alias LilliaWeb.PersonController.Show
  alias LilliaWeb.PersonController.Update

  action_fallback LilliaWeb.FallbackController

  @doc false
  def index(conn, params) do
    persons = Index.handle(params)

    render(conn, :index, persons: persons)
  end

  @doc false
  def create(conn, params) do
    with {:ok, person} <- Create.handle(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/persons/#{person}")
      |> render(:show, person: person)
    end
  end

  @doc false
  def show(conn, params) do
    with {:ok, person} <- Show.handle(params) do
      render(conn, :show, person: person)
    end
  end

  @doc false
  def update(conn, params) do
    with {:ok, person} <- Update.handle(params) do
      render(conn, :show, person: person)
    end
  end

  @doc false
  def delete(conn, params) do
    with {:ok, _person} <- Delete.handle(params) do
      send_resp(conn, :no_content, "")
    end
  end
end
