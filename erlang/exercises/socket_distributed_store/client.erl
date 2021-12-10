-module(client).
-export([start/1]).

start(Name, Path) ->
    case file:consult(Path) of
        {error, Why} ->
            exit({eDaemonConfig, Why})
        {ok, [{port, PortN},
              {service, ServiceName, password, Password, mfa, _, _, _}
             ]} ->
            S = self(),
            spawn_link(fun() -> try_connect(S, ServiceName, PortN, Password) end).
    end.

try_connect(Parent, Host, Port, Password, ServiceName) ->
    case lib_chan:connect(Host, Port, ServiceName, Password, []) of
        {error, _Why} ->
            io:format("error: '~p'~n", [_Why]),
            try_connect(Parent, Host, Port, Password, ServiceName);
        {ok, MM} ->
            lib_chan_mm:controller(MM, Parent), exit(connectionFinished)
    end.
