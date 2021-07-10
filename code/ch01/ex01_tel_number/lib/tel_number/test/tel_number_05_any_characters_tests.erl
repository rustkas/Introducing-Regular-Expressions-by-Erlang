-module(tel_number_05_any_characters_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

tel_numbers_01_dot_test() ->
    Expected = {match, ["707-827-7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "\\d\\d\\d.\\d\\d\\d.\\d\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

tel_numbers_02_dot_test() ->
    Expected = {match, ["707%827%7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "\\d\\d\\d.\\d\\d\\d.\\d\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

tel_numbers_03_dot_test() ->
    Expected = {match, ["707|827|7019"]},
    {match, [InputString]} = Expected,
    RegularExpression = "\\d\\d\\d.\\d\\d\\d.\\d\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

	
-endif.
