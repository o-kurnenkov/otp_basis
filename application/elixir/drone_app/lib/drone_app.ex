defmodule DroneApp do
  use Application

  def start(_type, _args) do
    DroneApp.Supervisor.start_link
  end
end
