defmodule Nearby.Repo do
  use Ecto.Repo,
    otp_app: :nearby,
    adapter: Ecto.Adapters.Postgres
end
