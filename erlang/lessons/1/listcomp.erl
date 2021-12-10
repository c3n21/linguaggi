-module(listcomp).
-export([qsort/2,main/0]).

qsort(_, []) -> [];
qsort(P, [Pivot|TL]) ->
    qsort(P, [X||X<-TL, P(X,Pivot)]) ++ [Pivot] ++ qsort(P, [X||X<-TL, not P(X,Pivot)]).

main() ->
    qsort(fun(X,Y) -> X<Y end, [4,1,56,7,5,2,3,5]).
