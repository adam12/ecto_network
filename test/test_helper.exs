ExUnit.start()

alias Ecto.Integration.TestRepo

Application.put_env(
  :ecto,
  TestRepo,
  adapter: Ecto.Adapters.Postgres,
  url: "ecto://localhost/ecto_network_test",
  pool: Ecto.Adapters.SQL.Sandbox
)

defmodule Ecto.Integration.TestRepo do
  use Ecto.Repo, otp_app: :ecto
end

{:ok, _} = Ecto.Adapters.Postgres.ensure_all_started(TestRepo, :temporary)

_ = Ecto.Adapters.Postgres.storage_down(TestRepo.config())
:ok = Ecto.Adapters.Postgres.storage_up(TestRepo.config())

{:ok, _pid} = TestRepo.start_link()

Code.require_file("ecto_migration.exs", __DIR__)

:ok = Ecto.Migrator.up(TestRepo, 0, Ecto.Integration.Migration, log: false)
Ecto.Adapters.SQL.Sandbox.mode(TestRepo, :manual)
Process.flag(:trap_exit, true)
