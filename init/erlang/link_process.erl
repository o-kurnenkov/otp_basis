% link_process.erl
%
-module(link_process).
-export([hello/0, start_link/0]).

start_link() ->
  process_flag(trap_exit, true),
  spawn_link(?MODULE, hello, []),
  receive X -> X end.

hello() ->
  io:format("~p: Already leaving...~n", [self()]),
  exit(sick_and_tired).


% Pid = process:start_link().
% kill Pid
% receive EXIT
