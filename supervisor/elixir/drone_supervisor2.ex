# drone_supervisor2.ex
defmodule DroneSupervisor2 do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :drone_supervisor)
  end

  def start_child(drone_name) do
    Supervisor.start_child(:drone_supervisor, [drone_name])
  end

  def which_children do
    Supervisor.which_children(:drone_supervisor)
  end

  def init(_) do
    drones = [
      worker(Drone, []) # Nothing is going to be started
    ]

    IO.puts("init DroneSup")
    supervise(drones, strategy: :simple_one_for_one)
  end
end

# Simple One for One
#
# {:ok, spid} = DroneSup.start_link
# DroneSup.start_child("IDDQD")
# DroneSup.start_child("IDKFA")
# DroneSup.which_children
# Process.whereis(:"Drone-IDKFA") |> Process.exit(:kill)
# DroneSup.which_children
# Process.exit(spid, :kill)
