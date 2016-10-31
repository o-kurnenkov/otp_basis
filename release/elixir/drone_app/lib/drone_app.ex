defmodule DroneApp do
  use Application

  def start(_type, _args) do
    {:ok, pid} = DroneApp.Supervisor.start_link

    DroneApp.Supervisor.start_child("IDKFA")
    DroneApp.Supervisor.start_child("IDDQD")

    {:ok, pid}
  end
end
