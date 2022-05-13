defmodule PracLive.Repo do
  use Ecto.Repo,
    otp_app: :prac_live,
    adapter: Ecto.Adapters.Postgres
end
