# drone_supervisor1.ex
defmodule DroneSupervisor1 do
  use Supervisor

  def start_link do Supervisor.start_link(__MODULE__, [], name: :drone_supervisor) end
  def which_children do Supervisor.which_children(:drone_supervisor) end

  def init(_) do
    drones = [
      worker(Drone, ["the-One"],   id: :drone_one),
      worker(Drone, ["the-Two"],   id: :drone_two),
      worker(Drone, ["the-Three"], id: :drone_three)
    ]

    IO.puts("init DroneSupervisor: one_for_one.")
    supervise(drones, strategy: :one_for_one)
    # supervise(drones, strategy: :rest_for_one)
    # supervise(drones, strategy: :one_for_all)
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
