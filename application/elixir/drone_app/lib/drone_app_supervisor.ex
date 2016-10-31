defmodule DroneApp.Supervisor do
  use Supervisor

  def start_link do Supervisor.start_link(__MODULE__, [], name: :drone_supervisor) end
  def which_children do Supervisor.which_children(:drone_supervisor) end

  def init(_) do
    drones = [
      worker(Drone, ["the-One"],   id: :drone_one),
      worker(Drone, ["the-Two"],   id: :drone_two),
      worker(Drone, ["the-Three"], id: :drone_three)
    ]

    IO.puts("init DroneApp Supervisor: one_for_one.")
    supervise(drones, strategy: :one_for_one)
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
