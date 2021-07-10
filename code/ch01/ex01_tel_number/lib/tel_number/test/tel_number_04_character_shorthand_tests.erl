-module(tel_number_04_character_shorthand_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

numbers_00_test() ->
    Expected = {match, [{0, 1}]},
    InputString = "7",
    RegularExpression = "\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP).

numbers_01_test() ->
    Expected = {match, [{0, 12}]},
    InputString = "707-827-7019",
    RegularExpression = "\\d\\d\\d-\\d\\d\\d-\\d\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
	% re:inspect(MP,namelist).
    Expected = re:run(InputString, MP).

numbers_02_list_test() ->
    Expected = {match, ["707-827-7019"]},
    InputString = "707-827-7019",
    RegularExpression = "\\d\\d\\d-\\d\\d\\d-\\d\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

numbers_03_global_test() ->
    Expected = {match,[["707-827-7019"]]},
    InputString = "707-827-7019",
    RegularExpression = "\\d\\d\\d-\\d\\d\\d-\\d\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list},global]).

numbers_04_list_test() ->
    Expected = {match, ["707-827-7019"]},
    InputString = "707-827-7019",
    RegularExpression = "\\d\\d\\d\\D\\d\\d\\d\\D\\d\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).	
	
-endif.
