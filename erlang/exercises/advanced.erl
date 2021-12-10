-module(advanced).
-export([start_1/0]).

start_1() ->
    INPUT = ["ceo", 1, "ceo"],
    io:format("input = ~p, squared = ~p~n", [INPUT, squared_int(INPUT)]),
    A = [1,2,3,4,5],
    B = [4,5,6,7,8],
    io:format("A = ~p, B = ~p, squared = ~p~n", [A, B, intersect(A,B)]),
    io:format("A = ~p, B = ~p, symmetric difference = ~p~n", [A, B, symmetric_difference(A,B)]).

squared_int(L) ->
    [X || X <- L, is_integer(X)].

intersect(L1, L2) ->
    [X || X <- L1, lists:any(fun (Y) -> X == Y end, L2)].

symmetric_difference(L1, L2) ->
    [X || X <- lists:append(L1,L2), not lists:any(fun (Y) -> X == Y end, intersect(L1, L2))].
