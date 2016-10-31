% messaging.erl
% 
-module(messaging).
-export([start/0, loop/0]).

start() -> spawn(fun() -> loop() end).

loop() ->
  receive
    {From, Msg} ->
      io:format("[~w] Got ~p from ~w~n",[self(), Msg, From]) ,
			From ! {self(), Msg} ,
			loop()
  end.
