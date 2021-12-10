-module(server).
-export([start_server/3, start/1]).

start(Path) -> lib_chan:start_server(Path).

start_server(MM, ArgC, SomeArgs) ->
    io:format("MM: ~p, ArgC: ~p, SomeArgs: ~p~n", [MM, ArgC, SomeArgs]),
    register(server,
        spawn(fun() ->
            process_flag(trap_exit, true),
            server_loop(MM)
        end)
    ).

server_loop(MM) ->
    receive
        {chan, MM, {store, Tag, Value}} ->
            io:format("chan: '~p', MM: '~p', Tag: '~p', Value: '~p'~n", [chan, MM, Tag, Value]),
            put(Tag, Value), server_loop(MM);
        {chan, MM, {lookup, Tag}} ->
            io:format("chan: '~p', MM: '~p', Tag: '~p'~n", [chan, MM, Tag]),
            io:format("get(Tag): '~p'~n", [get(Tag)]),
            server_loop(MM);
        Other -> server_loop(MM)
    end.
