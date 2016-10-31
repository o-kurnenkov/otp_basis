%% plug_in.erl
-module(plug_in).
-behaviour(gen_mod).

-export([start/0, connect/0]).
-export([do_start/0, do_connect/0]).

%% API
start()   -> gen_mod:start(?MODULE).
connect() -> gen_mod:connect(?MODULE).

%% gen_mod Callbacks
do_start()   -> io:format("Starting Plugin~n", []).
do_connect() -> io:format("Connecting Plugin~n", []).


% c(gen_mod).
% c(plug_in).
% gen_mod:start(plug_in).
