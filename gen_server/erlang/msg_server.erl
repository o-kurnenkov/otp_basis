%% msg_server.erl
-module(msg_server).
-behaviour(gen_server).

-export([history/0, send/2 ]).
-export([start_link/0, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3, terminate/2]).

%%%% Client API %%%%
start_link()  -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
stop()        -> gen_server:stop(?MODULE).
history()     -> gen_server:call(?MODULE, {history}   ).
send(Msg, To) -> gen_server:cast(?MODULE, {send, Msg, To} ).

%%%%%%% gen_server callbacks %%%%%%%
init(State) ->
  io:format("[~p] Starting~n", [?MODULE]),
  {ok, State}.

handle_cast({send, Message, To}, State) ->
  io:format("Sending message: ~p to ~p~n", [Message, To]),
  {noreply, [{send, calendar:local_time()}|State]}.

handle_call({history}, From, State) ->
  io:format("Received call 'history' from ~p~n", [From]),
  {reply, State, [{history, calendar:local_time()}|State]};
handle_call({stop}, From, State) ->
  io:format("Received call 'stop' from ~p~n", [From]),
  {reply, State, [{stop, calendar:local_time()}|State]}.

handle_info(_Message, State) -> {noreply, State}.
terminate(_Reason, State)    -> io:format("Terminating. State: ~p~n", [State]), ok.
code_change(_OldVersion, State, _Extra) -> {ok, State}.
