% For research mode, activate the RESEARCH constant.
% Printing characters, excluding letters, digits, and space
-module(posix_08_punct_tests).

%-define(RESEARCH, true).
-define(REGEX, "[[:punct:]]").

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").
-import(eunit_helper, [check_all_by_regex/3]).

-ifdef(RESEARCH).

research_test() ->
    Expected = ok,
    ValidCharacterList = lists:seq(0, 255),

    RegularExpression = ?REGEX,
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
                      ValidCharacterList),
    ?assertEqual(Expected, Result).

-else.

get_valid_character_list() ->
    ValidCharacterList =
        lists:seq(33, 47)
        ++ lists:seq(58, 64)
        ++ lists:seq(91, 96)
        ++ lists:seq(123, 126)
        ++ lists:seq(160, 169)
        ++ lists:seq(171, 180)
		++ lists:seq(182, 185)
        ++ lists:seq(187, 191)
        ++ [215, 247],
    ValidCharacterList.

research_01_test() ->
    Expected = true,
    ValidCharacterList = get_valid_character_list(),

    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression),
    Result = check_all_by_regex(MP, ValidCharacterList,true),
    ?assertEqual(Expected, Result).

research_02_test() ->
    Expected = true,
    ValidCharacterList = get_valid_character_list(),

    RegularExpression = "[[:^punct:]]",
    {ok, MP} = re:compile(RegularExpression),
    Result = check_all_by_regex(MP, ValidCharacterList,false),
    ?assertEqual(Expected, Result).

-endif.
-endif.
