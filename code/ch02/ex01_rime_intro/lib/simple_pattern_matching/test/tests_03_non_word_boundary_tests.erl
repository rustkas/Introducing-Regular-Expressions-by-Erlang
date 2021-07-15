-module(tests_03_non_word_boundary_tests).
%-define(RESEARCH, true).
%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

-ifdef(RESEARCH).

search_non_word_boundary_01_test() ->
    Expected = ok,
    ValidCharacterList =
        lists:seq(0, 47)
        ++ lists:seq(58, 64)
        ++ lists:seq(91, 94)
        ++ [96]
        ++ lists:seq(123, 255),
    RegularExpression = "\\B",
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

non_word_boundary_02_test() ->
    Expected = true,
    ValidCharacterList =
        lists:seq(0, 47)
        ++ lists:seq(58, 64)
        ++ lists:seq(91, 94)
        ++ [96]
        ++ lists:seq(123, 255),
    RegularExpression = "\\B",
    {ok, MP} = re:compile(RegularExpression),
    {match, _} = re:run(ValidCharacterList, MP),
    Result = true,
    ?assertEqual(Expected, Result).

-endif.

-endif.
