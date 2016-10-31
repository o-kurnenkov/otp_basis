defmodule DroneApp.Supervisor do
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
      # worker(Drone, ["the-One"]) # one_for_one
      worker(Drone, []) # simple_one_for_one
    ]

    IO.puts("init DroneSup")
    # supervise(drones, strategy: :one_for_one)
    # supervise(drones, strategy: :one_for_one)
    supervise(drones, strategy: :simple_one_for_one)
  end
end


# One For One:
#
# Process.flag(:trap_exit, true)
# Enum.each(["drone_supervisor.ex","drone.ex"],&c &1)
# {:ok, pid} = DroneSup.start_link
# [{_, dpid, _, _}] = Supervisor.which_children(:drone_supervisor)
# Process.exit(dpid, :kill)
# Drone.get_name(dpid)
#
# {:ok, spid} = DroneSup.start_link
# [{_, dpid, _, _}] = Supervisor.which_children(:drone_supervisor)
# Drone.get_name(dpid)
# Process.exit(spid, :kill)
# Drone.get_name(dpid)

# Simple One for One
#
# {:ok, spid} = DroneSup.start_link
# DroneSup.start_child("IDDQD")
# DroneSup.start_child("IDKFA")
# DroneSup.which_children
# Process.whereis(:"Drone-IDKFA") |> Process.exit(:kill)
# DroneSup.which_children
# Process.exit(spid, :kill)
