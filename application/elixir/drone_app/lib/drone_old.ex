defmodule DroneOld do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, [name: String.to_atom("Drone-#{name}")])
  end

  def get_name(pid) do
    GenServer.call(pid, :name)
  end

  def wazzup?(pid) do
    GenServer.call(pid, :wazzup)
  end

  def init(name) do
    IO.puts("INIT Drone-#{name}")
    {:ok, name}
  end

  def handle_call(:wazzup, from, state) do
     {:reply, :perfect, state}
  end

  def handle_call(:name, from, state) do
     {:reply, state, state}
  end

  def handle_call({:terminate_child, _sup}, _from, name) do
    IO.puts("Good TERMINATING #{name}")
    {:reply, name, name}
  end

  # def terminate(reason, name) do
  #   IO.puts("TERMINATING #{name}")
  #   {:ok, name}
  # end
end

# Drone.start_link(:OK)
