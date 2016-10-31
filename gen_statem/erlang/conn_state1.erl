-module(conn_state1).
-behaviour(gen_statem).
%% OTP supervision
-export([start_link/0, stop/0]).
-export([handshake/0,    ready/0,     disconnect/0,    %% state
         nice_weather/0, get_state/0, transitions/0]). %% transitions
%% OTP callbacks
-export([init/1, handle_event/4, code_change/4, callback_mode/0, terminate/3]).

start_link()  -> gen_statem:start_link({local, name()}, ?MODULE, [], []).
stop()        -> gen_statem:stop(name()).

handshake()   -> gen_statem:call(name(), handshake).      %%
ready()       -> gen_statem:call(name(), ready).          %%
disconnect()  -> gen_statem:call(name(), disconnect).     %% Client API
get_state()   -> gen_statem:call(name(), get_state).      %%
transitions() -> gen_statem:call(name(), transitions).    %%
nice_weather()-> gen_statem:cast(name(), nice_weather).   %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
init(_) ->
  State = Data = offline,
  io:format("[~p] Starting as ~p~n", [?MODULE, name()]),
  {ok, State, Data}.

terminate(_Reason, State, _Data) -> io:format("Terminating. State: ~p~n", [State]), ok.
code_change(_Vsn, State, Data, _Extra) -> {ok,State,Data}.
callback_mode() -> handle_event_function.
name() -> cs.

%% Event functions
handle_event({call, From}, handshake, offline, Data) ->
  {next_state, connecting, Data, [{reply, From, connecting}]};
handle_event({call, From}, ready, connecting, Data) ->
  {next_state, online, Data, [{reply, From, online}]};
handle_event({call, From}, disconnect, connecting, Data) ->
  {next_state, offline, Data, [{reply, From, offline}]};
handle_event({call, From}, disconnect, online, Data) ->
  {next_state, offline, Data, [{reply, From, offline}]};
handle_event({call,From}, get_state, State, Data) ->
  {next_state, State, Data, [{reply, From, State}]};
handle_event({call, From}, _, State, Data) ->
  {next_state, State, Data, [{reply, From, "NA. call :transitions()."}]};

handle_event(cast, nice_weather, State, Data) ->
    io:format("Indeed! :)~n", []),
    {next_state, State, Data};
handle_event(info, Msg, State, Data) ->
    io:format("Received message: ~p~n", [Msg]),
    {next_state, State, Data};
handle_event(_, _, State, Data) ->
    {next_state, State, Data}.


% Transitions map
% offline:
%   (handshake)  -> connecting
%
% connecting:
%   (ready)      -> online
%   (disconnect) -> offline
%
% online:
%   (disconnect) -> offline
handle_event({call, From}, transitions, State, Data) when State == offline ->
  {next_state, State, Data, [{reply, From, [handshake]}]};
handle_event({call, From}, transitions, State, Data) when State == connecting ->
  {next_state, State, Data, [{reply, From, [ready, disconnect]}]};
handle_event({call, From}, transitions, State, Data) when S/tate == online ->
  {next_state, State, Data, [{reply, From, [disconnect]}]};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% conn_state1:start_link().
% conn_state1:transitions().
% conn_state1:handshake().
% conn_state1:ready().
%
% conn_state1:get_state().
% sys:get_state(cs).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DOC %%%%%%%%%%%%%

% gen_statem module            Callback module
% -----------------            ---------------
% gen_statem:start
% gen_statem:start_link -----> Module:init/1
%
% Server start or code change
%                       -----> Module:callback_mode/0
%
% gen_statem:stop       -----> Module:terminate/3
%
% gen_statem:call
% gen_statem:cast
% erlang:send
% erlang:'!'            -----> Module:StateName/3
%                              Module:handle_event/4
%
% -                     -----> Module:terminate/3
%
% -                     -----> Module:code_change/4
