defmodule ClientStateHandler do
  use GenEvent

  def init(_) do {:ok, :ok} end

  def handle_event({:online, name}, state) do
    IO.puts("[Client state] #{name} is now online")
    {:ok, state}
  end

  def handle_event({:offline, name}, state) do
    IO.puts("[Client state] #{name} is now offline")
    {:ok, state}
  end

  def handle_event(_, state) do {:ok, state} end
  def handle_call(_, state) do {:ok, :ok, state} end
  def handle_info(_, state) do {:ok, state} end
  def code_change(_OldVsn, state, _Extra) do {:ok, state} end
  def terminate(_Reason, _state) do :ok end
end

# c("client_state_handler.ex")
# GenEvent.start_link(name: StateMan)
# GenEvent.add_handler(StateMan, ClientStateHandler, [])
# GenEvent.which_handlers(StateMan)
# GenEvent.notify(StateMan, {:online, "Man"})
# GenEvent.remove_handler(StateMan, ClientStateHandler, [])
