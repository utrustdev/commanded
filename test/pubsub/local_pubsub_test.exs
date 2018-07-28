defmodule Commanded.PubSub.LocalPubSubTest do
  alias Commanded.PubSub.{LocalPubSub, PubSubTestCase}

  use PubSubTestCase, pubsub: LocalPubSub

  setup do
    if Process.whereis(Commanded.PubSub.LocalPubSub) == nil do
      {:ok, _pid} = Supervisor.start_link(LocalPubSub.child_spec(), strategy: :one_for_one)
    end

    :ok
  end
end
