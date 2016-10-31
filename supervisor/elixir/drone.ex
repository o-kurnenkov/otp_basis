# drone.ex
defmodule Drone do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, [name: String.to_atom("Drone-#{name}")])
  end

  def get_name(pid) do GenServer.call(pid, :name) end
  def wazzup?(pid) do GenServer.call(pid, :wazzup) end

  def init(name) do IO.puts("INIT Drone-#{name}"); {:ok, name} end
  def handle_call(:wazzup, from, state) do {:reply, :perfect, state} end
  def handle_call(:name, from, state) do {:reply, state, state} end
end
