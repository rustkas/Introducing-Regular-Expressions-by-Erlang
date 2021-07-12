-module(tel_number_01_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

numbers_01_test() ->
    Expected = {match, [{0, 11}]},
    InputString = "77-827-7019",
    RegularExpression = InputString,
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP).

numbers_02_list_test() ->
    Expected = {match, ["77-827-7019"]},
    {match, [InputString]} = Expected,
    RegularExpression = InputString,
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

numbers_03_global_test() ->
    Expected = {match, [["77-827-7019"]]},
    {match, [[InputString]]} = Expected,
    RegularExpression = InputString,
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list},global]).

numbers_04_newline_test() ->
    Expected = {match, [["77-827-7019"]]},
    {match, [[InputString]]} = Expected,
    RegularExpression = InputString,
    {ok, MP} = re:compile(RegularExpression,[{newline, crlf}]),
    Expected = re:run(InputString, MP, [{newline, crlf},{capture,all,list},global]).


	
-endif.
