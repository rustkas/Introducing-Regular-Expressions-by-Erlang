-module(tel_number_09_quating_literals_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

tel_numbers_quating_literals_01_01_test() ->
    Expected = {match, ["(707)827-7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "^(\\(\\d{3}\\)|^\\d{3}[.-]?)?\\d{3}[.-]?\\d{4}$",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, first, list}]).

tel_numbers_quating_literals_01_02_test() ->
    Expected = {match, ["827-7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "^(\\(\\d{3}\\)|^\\d{3}[.-]?)?\\d{3}[.-]?\\d{4}$",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, first, list}]).

tel_numbers_quating_literals_01_03_test() ->
    Expected = {match, ["707-827-7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "^(\\(\\d{3}\\)|^\\d{3}[.-]?)?\\d{3}[.-]?\\d{4}$",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, first, list}]).
	
-endif.
