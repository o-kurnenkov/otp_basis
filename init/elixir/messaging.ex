# messaging.ex
#
defmodule Messaging do
  def start do spawn(fn -> loop end) end

  def loop do
    receive do
      {from, msg} ->
        pid = Kernel.inspect(self)
        from_pid = Kernel.inspect(from)
        IO.puts("[#{pid}] Got #{msg} from #{from_pid}")
  			send(from, {self, msg})
  			loop
    end
  end
end
