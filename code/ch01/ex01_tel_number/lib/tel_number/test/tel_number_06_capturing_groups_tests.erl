-module(tel_number_06_capturing_groups_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

tel_numbers_01_dot_test() ->
    Expected = {match,["707-827-7019","7"]},
	{match, [InputString|_]} = Expected,
    RegularExpression = "(\\d)\\d\\1-\\d\\d\\1-\\1\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

tel_numbers_02_comments_test() ->
    Expected = {match, ["707%827%7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "(\\d)\\d\\1\\D\\d\\d\\1\\D\\1\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, first, list}]).

tel_numbers_03_dot_test() ->
    Expected = {match, ["707|827|7019"]},
    {match, [InputString]} = Expected,
    RegularExpression = "(\\d)0\\1\\D\\d\\d\\1\\D\\1\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, first, list}]).

	
-endif.
