-module(controller).
-export([start/1]).

start(MM) ->
    process_flag(trap_exit, true),
    io:format("controller off we go ...~p~n", [MM]),
    loop(MM).

loop(MM) ->
    receive
        {chan, MM, msg} ->
            server ! {mm, MM, Msg},
            loop(MM);
        {'EXIT', MM, _Why} ->
            server ! {mm_closed, MM};
        Other ->
            io:format("unexpected message =~p (MM=~p)~n", [Other, MM]),
            loop(MM)
    end.
