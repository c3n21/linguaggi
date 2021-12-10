-module(ms).
-export([start/1, to_slave/2]).

start(N) when N>0 -> 
    register(master,
        spawn(fun() ->
            start(N, [])
            end
        )
    ).

start(0, L) ->
    loop_server(L);
    
start(N, L) ->
    io:format("Creating process '~p'...~n", [N]),
    Pid = spawn(fun() -> loop_slave() end),
    start(N-1, lists:append(L, [Pid])).

to_slave(Msg, Slave) ->
    master ! {Msg, Slave}.

loop_server(L) ->
    io:format("Processes: ~p~n", [L]),
    receive
        {Msg, Slave} ->
            io:format("Sending Msg: '~p' to Slave: '~p'~n", [Msg, Slave]),
            Pid = lists:nth(Slave, L),
            io:format("Found Pid: '~p'~n", [Pid]),
            Pid ! {msg, Msg}, loop_server(L);
%                error ->
%                    io:format("Couldn't send '~p' to Slave '~p' not found~n",
%                    [Msg, Slave]), loop_server(L)
        {die} ->
            ok
    end.

loop_slave() ->
    receive
        {msg, Msg} ->
            case get(msg) of
                undefined -> put(msg, [Msg]),
                L -> put(msg, lists:append(L, [Msg]))
            end, loop_slave();
        {retrieve} ->
            io:format("Pid: '~p' retrieving...~n", [self()]),
            case get(msg) of
                undefined -> io:format("Nothing found.~n"),
                L -> io:format("L: '~p'~n", L)
            end,
            loop_slave();
        {die} ->
            ok
    end.
