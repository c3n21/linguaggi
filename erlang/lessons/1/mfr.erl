% Mother father
-module(mfr).
-export([map/2,filter/2,reduce/2,main/0]).

map(_, []) -> [];
map(F,[HD|TL]) -> [F(HD)|map(F, TL)].

filter(_, []) -> [];
filter(P, [HD|TL]) -> filter(P(HD), P, HD, TL).

filter(true, P, HD, L) -> [HD|filter(P, L)];
filter(false, P, _, L) -> filter(P, L).

reduce(F, [HD|TL]) -> reduce(F, HD, TL).
reduce(_, Q, []) -> Q;
reduce(F, Q, [HD|TL]) -> reduce(F, F(Q,HD), TL).

main() ->
    L = ["Stronzo", "Di", "Merda"],
    Ls = map(fun(X) -> string:length(X) end, L),
    % io:fwrite("L = ~p~n", L).
    io:fwrite("L = ~p~n", [L]),
    io:fwrite("map = ~p~n", [Ls]),
    io:fwrite("filter = ~p~n", [filter(fun(X)->X>6 end, Ls)]),
    io:fwrite("reduce = ~p~n", [reduce(fun(X,Y)->X+Y end, Ls)]).
    
    
