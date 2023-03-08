defmodule LiveStudio.Repo do
  use Ecto.Repo,
    otp_app: :live_studio,
    adapter: Ecto.Adapters.Postgres
end
