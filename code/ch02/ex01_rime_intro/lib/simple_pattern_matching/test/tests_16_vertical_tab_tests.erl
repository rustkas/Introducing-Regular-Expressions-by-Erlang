% For research mode, activate the RESEARCH constant.
% Vertical tab (whitespace)
-module(tests_16_vertical_tab_tests).

%-define(RESEARCH, true).
-define(REGEX, "\\v").

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

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
    ValidCharacterList = lists:seq(10,13) ++[133],
    ValidCharacterList.

research_01_test() ->
    Expected = true,
    ValidCharacterList = get_valid_character_list(),
    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression),
    {match, _} = re:run(ValidCharacterList, MP),
    Result = true,
    ?assertEqual(Expected, Result).

research_02_test() ->
    Expected = true,
    ValidCharacterList = get_valid_character_list(),
    RegularExpression = "[^\\v]",
    {ok, MP} = re:compile(RegularExpression),
    nomatch = re:run(ValidCharacterList, MP),
    Result = true,
    ?assertEqual(Expected, Result).

-endif.
-endif.
