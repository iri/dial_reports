-module(dial_reports).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(_Args) ->
    process_file("priv/list_erl.txt"),
    process_file("priv/list_hrl.txt"),
    process_file("priv/list_c.txt"),
    process_file("priv/list_h.txt"),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

process_file(Filename) ->
    Proc = fun(Tokens) -> 
                io:format("~p~n",[Tokens])
           end,
    {ok, File} = file:open(Filename, [read]),
    read_lines(File, Proc),
    file:close(File).

read_lines(File, Proc) ->
    case io:get_line(File, "") of
        eof ->
            ok;
        {error, Reason} ->
            throw({error, Reason});
        Line ->
            [_|Tokens] = string:split(Line, "/", all),
            Proc(Tokens),
            read_lines(File, Proc)
    end.

