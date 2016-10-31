%% common_server.erl
-module(common_server).
-export([init/0, get_state/0, send/1, loop/1]).
% API
init()      -> register(singleton, spawn(?MODULE, loop, [ [] ])).
get_state() -> singleton ! {self(), get_state}.
send(Msg)   -> singleton ! {self(), Msg}.
% internal loop
loop(State) ->
  receive
    {From, get_state} ->
      From ! {self(), State},
      loop(State);
    {_, Msg} ->
      NewState = [Msg | State],
      loop(NewState)
  end.
