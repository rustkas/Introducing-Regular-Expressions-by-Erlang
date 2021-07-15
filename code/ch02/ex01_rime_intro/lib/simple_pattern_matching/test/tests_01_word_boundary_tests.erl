-module(tests_01_word_boundary_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

word_boundary_01_test() ->
    Expected = ok,
    Numbers = lists:seq(48, 57),
    BigLetters = lists:seq(65, 90),
    DashLetter = [95],
    SmallLetters = lists:seq(97, 122),
    ValidCharacterList = Numbers ++ BigLetters ++ DashLetter ++ SmallLetters,
    RegularExpression = "\\b",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:foreach(fun(Elem) -> {match, _} = re:run([Elem], MP) end,
                      ValidCharacterList),
    ?assertEqual(Expected, Result).

-endif.
