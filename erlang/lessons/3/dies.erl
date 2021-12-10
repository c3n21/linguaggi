-module(dies).
-export([on_exit/2, main/0]).

on_exit(Pid, Fun) ->
    spawn(fun() ->
                  process_flag(trap_exit, true),
                  link(Pid),
                  receive
                      {'EXIT', Pid, Why} -> Fun(Why)
                  end
          end).

main() ->
    F = fun() -> receive X -> list_to_atom(X) end end,
    Pid = spawn(F),
    on_exit(Pid, fun(Why) -> io:format("~p died with: ~p~n", [Pid,Why]) end),
    Pid ! hello.
