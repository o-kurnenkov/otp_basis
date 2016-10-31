# process.ex
#
defmodule Process do
  def start do
    spawn(__MODULE__, :hello, [])
  end

  def hello do
    IO.puts("Hello from #{Kernel.inspect(self)}")
  end
end


# % start_link() ->
# %   spawn_link(?MODULE, hello, []).
#
# % process:hello().
# % process:start().
# % spawn( fun() -> process:hello() end).
