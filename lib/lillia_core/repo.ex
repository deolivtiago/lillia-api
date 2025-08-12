defmodule LilliaCore.Repo do
  use Ecto.Repo,
    otp_app: :lillia,
    adapter: Ecto.Adapters.Postgres
end
