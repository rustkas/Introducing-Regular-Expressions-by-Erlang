-module(tel_number_02_7_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

numbers_01_test() ->
    Expected = {match, [{0, 1}]},
    InputString = "77-827-7019",
    RegularExpression = "7",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP).

numbers_02_list_test() ->
    Expected = {match, ["7"]},
    InputString = "77-827-7019",
    RegularExpression = "7",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

numbers_03_global_test() ->
    Expected = {match,[["7"],["7"],["7"],["7"]]},
    InputString = "77-827-7019",
    RegularExpression = "7",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list},global]).

numbers_04_newline_test0() ->
    Expected = {match,[["7"],["7"],["7"],["7"]]},
    InputString = "77-827-7019",
    RegularExpression = "7",
    {ok, MP} = re:compile(RegularExpression,[{newline, crlf}]),
    Expected = re:run(InputString, MP, [{newline, crlf},{capture,all,list},global]).
	
-endif.
