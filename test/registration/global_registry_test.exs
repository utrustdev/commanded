defmodule Commanded.Registration.GlobalRegistryTest do
  alias Commanded.Registration.{GlobalRegistry, RegistrationTestCase}

  use RegistrationTestCase, registry: GlobalRegistry

  setup do
    Application.put_env(:commanded, :registry, :global)

    on_exit(fn ->
      Application.delete_env(:commanded, :pubsub)
    end)
  end
end
