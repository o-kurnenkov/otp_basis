%% client_handler.erl
-module(client_handler).
-behaviour(gen_event).
-export([init/1, handle_event/2, handle_call/2, handle_info/2, code_change/3,
         terminate/2]).

init([]) -> {ok, ok}.

handle_event({online, Name}, State) ->
  io:format("[Client State] ~p is now online~n",[Name]),
  {ok, State};
handle_event({offline, Name}, State) ->
  io:format("[Client State] ~p is now offline~n",[Name]),
  {ok, State};
handle_event(_, State) ->
  {ok, State}.

handle_call(_, State) -> {ok, ok, State}.
handle_info(_, State) -> {ok, State}.
code_change(_OldVsn, State, _Extra) -> {ok, State}.
terminate(_Reason, _State) -> ok.


% c("client_handler.erl").
% gen_event:start_link({local, state_man}).
% gen_event:add_handler(state_man, client_handler, []).
% gen_event:which_handlers(state_man).
% gen_event:notify(state_man, {online, "Man"}).
% gen_event:delete_handler(state_man, client_handler, []).

