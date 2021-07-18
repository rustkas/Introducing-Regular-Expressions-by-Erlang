% For research mode, activate the RESEARCH constant.
% Horizontal whitespace
-module(tests_11_horizontal_whitespace_tests).

%-define(RESEARCH, true).
-define(REGEX, "\\h").

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
    ValidCharacterList = [9, 32, 160],
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
    RegularExpression = "[^\\h]",
    {ok, MP} = re:compile(RegularExpression),
    Result = check_all_by_regex(MP, ValidCharacterList,false),
    ?assertEqual(Expected, Result).

research_03_test() ->
    Expected = true,
    ValidCharacterList = get_valid_character_list(),
    RegularExpression = "[\\h]",
    {ok, MP} = re:compile(RegularExpression),
    Result = check_all_by_regex(MP, ValidCharacterList,true),
    ?assertEqual(Expected, Result).
	
research_04_test() ->
    Expected = true,
    ValidCharacterList = get_valid_character_list(),
    RegularExpression = "^[\\h]",
    {ok, MP} = re:compile(RegularExpression),
    Result = check_all_by_regex(MP, ValidCharacterList,true),
    ?assertEqual(Expected, Result).
-endif.
-endif.
