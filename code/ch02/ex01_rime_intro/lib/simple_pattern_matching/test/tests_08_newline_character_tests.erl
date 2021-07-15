-module(tests_08_newline_character_tests).
%-define(RESEARCH, true).
%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

-ifdef(RESEARCH).

search_decimal_value_01_test() ->
    Expected = ok,
    ValidCharacterList = lists:seq(0, 255),
    % octal code
    RegularExpression = "\\n",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:foreach(fun(Elem) ->
                         case re:run([Elem], MP) of
                             {match, _} ->
                                 %true;
                                 ?debugFmt("Found! = ~p~n", [Elem]);
                             nomatch ->
                                 false
                         end
                      end,
                      %{match, _} = re:run([Elem], MP)
                      ValidCharacterList),
    ?assertEqual(Expected, Result).

-else.

form_feed_02_test() ->
    Expected = true,
    ValidCharacterList = [10],
    % octal code
    RegularExpression = "\\n",
    {ok, MP} = re:compile(RegularExpression),
    {match, _} = re:run(ValidCharacterList, MP),
    Result = true,
    ?assertEqual(Expected, Result).

form_feed_03_test() ->
    Expected = true,
    ValidCharacterList = [10],
    % octal code
    RegularExpression = "[\\n]",
    {ok, MP} = re:compile(RegularExpression),
    {match, _} = re:run(ValidCharacterList, MP),
    Result = true,
    ?assertEqual(Expected, Result).

-endif.

-endif.
