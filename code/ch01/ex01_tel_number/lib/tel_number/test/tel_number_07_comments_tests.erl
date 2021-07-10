-module(tel_number_07_comments_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

tel_numbers_01_comments_test() ->
    Expected = {match, ["707%827%7019"]},
	{match, [InputString]} = Expected,
    RegularExpression = "(?#first part)" "(\\d)\\d\\1" "\\D" "(?#second part)" "\\d\\d\\1" "\\D" "(?#third part)" "\\1\\d\\d\\d",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, first, list}]).

	
-endif.
