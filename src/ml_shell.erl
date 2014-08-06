-module(ml_shell).

-export([start/0]).

start() ->
    server().

server() ->
    io:fwrite("ML Shell V~s (abort with ^G)\n",
	      [erlang:system_info(version)]),
    server_loop().

server_loop() ->
    case io:get_line("?") of
        eof ->
            eof;
        {error, ErrorDescription} ->
            io:fwrite("Error ~p~n", [ErrorDescription]);
        Data ->
            String = string:strip(Data),
            {ok, Tokens, _} = ml_scan:string(String),
            io:fwrite("Data: ~p Parsed: ~p~n", [String, Tokens])
    end,
    server_loop().
