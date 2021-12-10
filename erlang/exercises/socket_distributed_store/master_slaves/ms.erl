-module(ms).
-export([]).

start(0) ->
    ok;

start(N) when N>0 -> 
    .

start(N, L)

loop_slave() ->
    receive
        {die} ->
            ok.
    end.
