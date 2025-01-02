-module(dial_reports).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(Args) ->
    Filename = lists:nth(1, Args),
    {ok, File} = file:open(Filename, [read]),
    read_lines(File),
    file:close(File),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

read_lines(File) ->
    case io:get_line(File, "") of
        eof ->
            ok;
        {error, Reason} ->
            throw({error, Reason});
        Line ->
            io:format("~p~n",[Line]),
            read_lines(File)
    end.

