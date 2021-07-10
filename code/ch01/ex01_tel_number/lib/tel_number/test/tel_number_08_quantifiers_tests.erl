-module(tel_number_08_quantifiers_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

tel_numbers_quantifiers_01_test() ->
    Expected = {match, ["707-827-7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "\\d{3}-\\d{3}-\\d{4}",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

tel_numbers_quantifiers_02_question_mark_01_test() ->
    Expected = {match, ["707-827-7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "\\d{3}-?\\d{3}-?\\d{4}",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

tel_numbers_quantifiers_02_question_mark_02_test() ->
    Expected = {match, ["707827-7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "\\d{3}-?\\d{3}-?\\d{4}",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

tel_numbers_quantifiers_02_question_mark_03_test() ->
    Expected = {match, ["707-8277019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "\\d{3}-?\\d{3}-?\\d{4}",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

tel_numbers_quantifiers_02_question_mark_04_test() ->
    Expected = {match, ["7078277019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "\\d{3}-?\\d{3}-?\\d{4}",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

tel_numbers_quantifiers_03_compact_01_test() ->
    Expected = {match, ["707-827-7019", "7019"]},
	{match, [InputString|_]} = Expected,
    RegularExpression = "(\\d{3,4}[.-]?)+",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

tel_numbers_quantifiers_03_compact_02_test() ->
    Expected = {match, ["707.827.7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "(\\d{3,4}[.-]?)+",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, first, list}]).

tel_numbers_quantifiers_04_compact_01_test() ->
    Expected = {match, ["707-827-7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "(\\d{3}[.-]?){2}\\d{4}",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, first, list}]).

tel_numbers_quantifiers_04_compact_02_test() ->
    Expected = {match, ["707.827.7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "(\\d{3}[.-]?){2}\\d{4}",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, first, list}]).
	
-endif.
