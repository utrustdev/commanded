defmodule Commanded.Registration.RegisteredServer do
  use GenServer
  use Commanded.Registration

  def start_link(name, opts \\ []) do
    GenServer.start_link(__MODULE__, name, opts)
  end

  def init(name), do: {:ok, name}

  def ping(name), do: GenServer.call(via_tuple(name), :ping)

  def handle_call(:ping, _from, state) do
    {:reply, :pong, state}
  end
end
