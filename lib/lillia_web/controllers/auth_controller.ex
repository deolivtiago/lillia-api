defmodule LilliaWeb.AuthController do
  @moduledoc false

  use LilliaWeb, :controller

  alias LilliaWeb.AuthController.ChangeEmail
  alias LilliaWeb.AuthController.ChangePassword
  alias LilliaWeb.AuthController.ConfirmAccount
  alias LilliaWeb.AuthController.RefreshToken
  alias LilliaWeb.AuthController.ResetPassword
  alias LilliaWeb.AuthController.SendCode
  alias LilliaWeb.AuthController.SignIn
  alias LilliaWeb.AuthController.SignOut
  alias LilliaWeb.AuthController.SignUp

  action_fallback LilliaWeb.FallbackController

  @doc false
  def sign_up(conn, params) do
    with {:ok, user} <- SignUp.handle(params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  @doc false
  def sign_in(conn, params) do
    with {:ok, tokens} <- SignIn.handle(params) do
      conn
      |> put_status(:ok)
      |> render(:show, tokens: tokens)
    end
  end

  @doc false
  def sign_out(conn, params) do
    SignOut.handle(params)

    send_resp(conn, :no_content, "")
  end

  @doc false
  def send_code(conn, params) do
    with {:ok, _user} <- SendCode.handle(params) do
      send_resp(conn, :no_content, "")
    end
  end

  @doc false
  def confirm_account(conn, params) do
    with {:ok, user} <- ConfirmAccount.handle(params) do
      render(conn, :show, user: user)
    end
  end

  @doc false
  def reset_password(conn, params) do
    with {:ok, user} <- ResetPassword.handle(params) do
      render(conn, :show, user: user)
    end
  end

  @doc false
  def change_email(conn, params) do
    with {:ok, user} <- ChangeEmail.handle(params) do
      render(conn, :show, user: user)
    end
  end

  @doc false
  def change_password(conn, params) do
    with {:ok, user} <- ChangePassword.handle(params) do
      render(conn, :show, user: user)
    end
  end

  @doc false
  def refresh_token(conn, params) do
    with {:ok, tokens} <- RefreshToken.handle(params) do
      render(conn, :show, tokens: tokens)
    end
  end

  @doc false
  def user_info(%{assigns: %{current_user: user}} = conn, _params) do
    render(conn, :show, user: user)
  end
end
