-module(tests_08_alert_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

search_alert_character_01_test0() ->
    Expected = ok,
    ValidCharacterList = lists:seq(0,255),
    RegularExpression = "\\a",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:foreach(fun(Elem) ->
                         case re:run([Elem], MP) of
                             {match, _} ->
                                 true;
                             %?debugFmt("Found! = ~p~n",[Elem]);
                             nomatch ->
                                 false
                         end
                      end,
                      %{match, _} = re:run([Elem], MP)
                      ValidCharacterList),
    ?assertEqual(Expected, Result).

alert_character_02_test() ->
    Expected = true,
    ValidCharacterList = [7],
    RegularExpression = "\\a",
    {ok, MP} = re:compile(RegularExpression),
    {match, _} = re:run(ValidCharacterList, MP),
	Result = true,
    ?assertEqual(Expected, Result).

-endif.
