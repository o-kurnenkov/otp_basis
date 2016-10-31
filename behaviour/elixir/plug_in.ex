## plug_in.ex
defmodule PlugIn do
  @behaviour GenMod

  # API
  def start   do GenMod.start(__MODULE__)   end
  def connect do GenMod.connect(__MODULE__) end

  # GenMod Callbacks
  def do_start   do IO.puts("Starting plugin")   end
  def do_connect do IO.puts("Connecting Plugin") end
end
