%% gen_mod.erl
-module(gen_mod).
-export([start/1, connect/1, info/0]).

-callback do_start()  -> 'ok'.
-callback do_connect() -> 'ok'.
-optional_callbacs([info/0]).

start(Module) ->
  io:format("[erl gen_mod] Starting ~p~n", [Module]),
  apply(Module, do_start, []), 'ok'.

connect(Module) ->
  io:format("[erl gen_mod] Connecting ~p~n", [Module]),
  apply(Module, do_connect, []), 'ok'.

info() ->
  'Default implementation'.


% c("gen_mod.erl").
