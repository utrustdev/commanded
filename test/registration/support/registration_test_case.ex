defmodule Commanded.Registration.RegistrationTestCase do
  import Commanded.SharedTestCase

  define_tests do
    use Commanded.StorageCase

    alias Commanded.Registration.{RegisteredSupervisor, RegisteredServer}

    setup do
      {:ok, _pid} = RegisteredSupervisor.start_link()

      :ok
    end

    describe "`start_child/3`" do
      test "should return child process `pid` on success", %{registry: registry} do
        assert {:ok, pid} = registry.start_child("child", RegisteredSupervisor, ["child"])
        assert Process.alive?(pid)
      end

      test "should return existing child process when already started", %{registry: registry} do
        assert {:ok, pid} = registry.start_child("child", RegisteredSupervisor, ["child"])
        assert {:ok, ^pid} = registry.start_child("child", RegisteredSupervisor, ["child"])
      end

      test "should allow calling child process by name", %{registry: registry} do
        {:ok, _pid} = registry.start_child("child", RegisteredSupervisor, ["child"])

        assert :pong = RegisteredServer.ping("child")
      end
    end

    describe "`start_link/3`" do
      test "should return process `pid` on success", %{registry: registry} do
        assert {:ok, _pid} = registry.start_link("registered", RegisteredServer, ["registered"])
      end

      test "should return existing process when already started", %{registry: registry} do
        assert {:ok, pid} = registry.start_link("registered", RegisteredServer, ["registered"])
        assert {:ok, ^pid} = registry.start_link("registered", RegisteredServer, ["registered"])
      end

      test "should allow calling process by name", %{registry: registry} do
        {:ok, _pid} = registry.start_link("registered", RegisteredServer, ["registered"])

        assert :pong = RegisteredServer.ping("registered")
      end
    end

    describe "`whereis_name/1`" do
      test "should return `:undefined` when not registered", %{registry: registry} do
        assert registry.whereis_name("unregistered") == :undefined
      end

      test "should return `pid` when child registered", %{registry: registry} do
        assert {:ok, pid} = registry.start_child("child", RegisteredSupervisor, ["child"])
        assert registry.whereis_name("child") == pid
      end

      test "should return `pid` when `GenServer` process registered", %{registry: registry} do
        assert {:ok, pid} = registry.start_link("registered", RegisteredServer, ["registered"])
        assert registry.whereis_name("registered") == pid
      end
    end
  end
end
