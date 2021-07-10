-module(tel_number_03_digits_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

numbers_01_test() ->
    Expected = {match, [{0, 1}]},
    InputString = "707-827-7019",
    RegularExpression = "[0-9]",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP).

numbers_02_list_test() ->
    Expected = {match, ["7"]},
    InputString = "707-827-7019",
    RegularExpression = "[0,1,2,7,8,9]",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

numbers_03_global_test() ->
    Expected = {match,[["707-827-7019"]]},
    InputString = "707-827-7019",
    RegularExpression = "[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list},global]).

	
-endif.
