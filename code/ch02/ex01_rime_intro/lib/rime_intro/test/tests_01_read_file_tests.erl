-module(tests_01_read_file_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

read_file_from_the_web() ->
    FileName =
        "https://github.com/rustkas/Introducing-Regular-Expressions/blob/master/rime-intro.txt",
    {ok, Result} = httpc:request(FileName),
    {StatusLine, _Headers, Body} = Result,
    {_HTTP_ID, 200, _Message} = StatusLine,
    %?debugFmt("StatusLIne = ~p~n", [StatusLine]),
    %?debugFmt("Headers = ~p~n", [Headers]).
    Body.

read_local_file() ->
    FileName = "rime-intro.txt",
    {ok, Dir} = file:get_cwd(),
    FullFileName = Dir ++ [$/] ++ FileName,
    {ok, Binary} = file:read_file(FullFileName),
    String = binary_to_list(Binary),
    %?debugFmt("Binary = ~p~n", [String]).
    String.

read_local_file_01_test() ->
    Expected = {match, ["Ship"]},
    InputString = read_local_file(),
    RegularExpression = "Ship",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

read_file_from_the_web_01_test() ->
    Expected = {match, ["Ship"]},
    InputString = read_file_from_the_web(),
    RegularExpression = "Ship",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

-endif.
