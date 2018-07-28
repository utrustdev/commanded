defmodule Commanded.Registration.LocalRegistryTest do
  alias Commanded.Registration.{LocalRegistry, RegistrationTestCase}

  use RegistrationTestCase, registry: LocalRegistry

  setup do
    if Process.whereis(LocalRegistry) == nil do
      {:ok, _pid} = Supervisor.start_link(LocalRegistry.child_spec(), strategy: :one_for_one)
    end

    :ok
  end
end
