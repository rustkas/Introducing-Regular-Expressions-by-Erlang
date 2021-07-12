-module(maching_digits_01_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

read_local_file() ->
    FileName = "rime-intro.txt",
    {ok, Dir} = file:get_cwd(),
    FullFileName = Dir ++ [$/] ++ FileName,
    {ok, Binary} = file:read_file(FullFileName),
    String = binary_to_list(Binary),
    %?debugFmt("Binary = ~p~n", [String]).
    String.

caseless_local_file_01_test() ->
    Expected = {match, ["1"]},
    InputString = read_local_file(),
    RegularExpression = "\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

caseless_local_file_02_test() ->
    Expected = {match, [["1"], ["2"], ["3"], ["4"]]},
    InputString = read_local_file(),
    RegularExpression = "\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}, global]).

        %?debugFmt("Expected = ~p~n", [Expected]).

caseless_local_file_03_test() ->
    Expected = {match, [["1"], ["2"], ["3"], ["4"]]},
    InputString = read_local_file(),
    RegularExpression = "[0-9]",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}, global]).

caseless_local_file_04_test() ->
    Expected = {match, [["1"], ["2"], ["3"], ["4"]]},
    InputString = read_local_file(),
    RegularExpression = "[0123456789]",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}, global]).

caseless_local_file_05_test() ->
    Expected = {match, [["1"]]},
    InputString = read_local_file(),
    RegularExpression = "[01]",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}, global]).

caseless_local_file_06_test() ->
    Expected = {match, [["1"], ["2"]]},
    InputString = read_local_file(),
    RegularExpression = "[12]",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}, global]).

-endif.
