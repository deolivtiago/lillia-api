defmodule LilliaWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use LilliaWeb, :controller

  @doc """
  This clause handles errors returned by `Ecto.Changeset`
  """
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: LilliaWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end
end
