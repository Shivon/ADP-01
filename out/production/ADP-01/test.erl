%%%-------------------------------------------------------------------
%%% @author KamikazeOnRoad
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. Nov 2014 20:35
%%%-------------------------------------------------------------------
-module(test).
-author("KamikazeOnRoad").

%% API
-export([print_hello/0, map_all_the_lists/0, squareList/1]).

print_hello()->
  io:format("Hello World ~n Blubb ~n").

%% List Comprehensions
map_all_the_lists() ->
  [X+1 || X <- [1,2,3], X rem 2==0].

squareList(Y) ->
  [X*X || X <- Y, X rem 2==0].