% For research For research mode, activate the RESEARCH constant.
%
-module(line_03_quoting_group_characters_as_literal_tests).
%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

-ifdef(RESEARCH).

research_test() ->
    %that characters can not be into Regular Expression
    _RestrictedCharacters = "+?()[",
    %that characters can be into Regular Expression
    String = "*.^$|{}]\-",
    Result =
        lists:foreach(fun(Elem) ->
                         {ok, MP} = re:compile([Elem]),
                         case re:run([Elem], MP) of
                             {match, _} ->
                                 ?debugFmt("Found! = ~p~n", [[Elem]]);
                             nomatch ->
                                 false
                         end
                      end,
                      String).

-else.

compile_01_test() ->
    Expected = {error, {"nothing to repeat", 0}},
    Regex = "*",
    Result = re:compile(Regex),
    ?assertEqual(Expected, Result).

compile_02_test() ->
    Expected = {error, {"nothing to repeat", 0}},
    Regex = "+",
    Result = re:compile(Regex),
    ?assertEqual(Expected, Result).

compile_03_test() ->
    Expected = {error, {"nothing to repeat", 0}},
    Regex = "?",
    Result = re:compile(Regex),
    ?assertEqual(Expected, Result).

compile_04_test() ->
    Expected = {error, {"missing )", 1}},
    Regex = "(",
    Result = re:compile(Regex),
    ?assertEqual(Expected, Result).

compile_05_test() ->
    Expected = {error, {"unmatched parentheses", 0}},
    Regex = ")",
    Result = re:compile(Regex),
    ?assertEqual(Expected, Result).

compile_06_test() ->
    Expected = {error, {"missing terminating ] for character class", 1}},
    Regex = "[",
    Result = re:compile(Regex),
    ?assertEqual(Expected, Result).

save_compile_01_test() ->
    Expected = true,
    AvoidCharacters = "*.^$|{}]\-",
    Result =
        lists:all(fun(Elem) ->
                     Regex = "\\Q" ++ [Elem] ++ "\\E",
                     {ok, _} = re:compile(Regex),
                     true
                  end,
                  AvoidCharacters),

    ?assertEqual(Expected, Result).

-endif.
-endif.
