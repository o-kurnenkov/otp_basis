% process.erl
%
-module(process).
-export([hello/0, start/0]).

start() ->
  spawn(?MODULE, hello, []).

hello() ->
  io:format("Hello from ~w~n", [self()]).


% process:hello().
% process:start().
% spawn( fun() -> process:hello() end).
