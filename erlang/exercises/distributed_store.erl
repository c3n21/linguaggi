-module(distributed_store).
-export([master/2, update/2]).

master(L, start) ->
    register(master, spawn(fun() -> 
        lists:foreach(fun(X) ->
            io:format("Creating sub-process: '~p'~n", [X]),
            register(X, spawn(fun() ->
                    server_loop()
            end))
        end, L),
        master(L, loop)
    end));

master(L, loop) ->
    receive
        {Tag, Value} ->
            lists:foreach(fun(X) ->
                io:format("Updating ~p...~n", [X]),
                X ! {self(), Tag, Value}
            end, L),
            master(L, loop);
        {stop} ->
            lists:foreach(fun(X) ->
                io:format("Terminating ~p...~n", [X]),
                X ! {exit}
            end, L),
            io:format("All terminated...~n"),
            true
    end.

update(Tag, Value) ->
    master ! {Tag, Value}.

server_loop() ->
    receive
        {_, Tag, Value} ->
            put(Tag, Value), server_loop();
        {From, Tag} ->
            From ! get(Tag),
            io:format("Tag: ~s, Value: ~s~n", [Tag, get(Tag)]),
            server_loop();
        {exit} -> true;
        Other ->
            io:format("Unknown: ~p~n", [Other]), server_loop
    end.

