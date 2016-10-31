## gen_mod.ex
defmodule GenMod do
  @callback do_start   :: :ok
  @callback do_connect :: :ok

  def start(module) do
    IO.puts("[GenMod] Starting Module #{Kernel.inspect(module)}")
    module.do_start
    :ok
  end

  def connect(module) do
    IO.puts("[GenMod] Connecting Module #{Kernel.inspect(module)}")
    module.do_start
    :ok
  end
end
