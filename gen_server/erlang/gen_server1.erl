% gen_server module            Callback module
% -----------------            ---------------
% gen_server:start
% gen_server:start_link -----> Module:init/1
%
% gen_server:stop       -----> Module:terminate/2
%
% gen_server:call
% gen_server:multi_call -----> Module:handle_call/3
%
% gen_server:cast
% gen_server:abcast     -----> Module:handle_cast/2
%
% -                     -----> Module:handle_info/2
%
% -                     -----> Module:terminate/2
%
% -                     -----> Module:code_change/3
% gen_server1.erl
-module(gen_server1).
-behaviour(gen_server).

-export([start_link/0, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3, terminate/2]).

%%%% Client API %%%%
start_link()  -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
stop()        -> gen_server:stop(?MODULE).

%%%%%%% gen_server callbacks %%%%%%%
init(State)                             -> {ok, State}.
handle_call(some_call, From, State)     -> {reply, some_reply, State}.
handle_cast(some_cast, State)           -> {noreply, State}.
handle_info(_Message, State)            -> {noreply, State}.
terminate(_Reason, State)               -> ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.
