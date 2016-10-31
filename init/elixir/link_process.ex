# link_process.ex
#
defmodule LinkProcess do
  def start_link do
    Process.flag(:trap_exit, true)
    spawn_link(__MODULE__, :hello, [])
    receive do x -> x end
  end

  def hello do
    self_pid = Kernel.inspect(self)
    IO.puts("#{self_pid}: can't find erlang's i().!")
    exit(:enough_of_this)
  end
end
