defmodule MsgServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  end

  def stop do
    GenServer.stop(__MODULE__)
  end

  def send(msg, to) do GenServer.cast(__MODULE__, {:send, msg, to}) end
  def history       do GenServer.call(__MODULE__, {:history}      ) end

  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  def init(state) do
    IO.puts("#{__MODULE__} Starting")
    {:ok, state}
  end

  def handle_cast({:send, msg, to}, state) do
    IO.puts("Sending message: #{msg} to #{to}")
    {:noreply, [{:send, :calendar.local_time}|state]}
  end

  def handle_call({:history}, from, state) do
    IO.puts("Received call 'history' from #{Kernel.inspect(from)}")
    {:reply, state, [{:history, :calendar.local_time}|state]}
  end
end
