% For research For research mode, activate the RESEARCH constant.
% Letters.
-module(posix_01_alpha_tests).

%-define(RESEARCH, true).
-define(REGEX, "[[:alpha:]]").

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").
-import(eunit_helper, [check_all_by_regex/3]).

-ifdef(RESEARCH).

letters_research_test() ->
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
                      %{match, _} = re:run([Elem], MP)
                      ValidCharacterList),
    ?assertEqual(Expected, Result).

-else.

get_valid_character_list() ->
        ValidCharacterList =
        lists:seq(65, 90)
        ++ [97, 122]
        ++ [170, 181, 186]
        ++ lists:seq(192, 214)
        ++ lists:seq(216, 246)
        ++ lists:seq(248, 255),
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
    RegularExpression = "[[:^alpha:]]",
    {ok, MP} = re:compile(RegularExpression),
    Result = Result = check_all_by_regex(MP, ValidCharacterList,false),
    ?assertEqual(Expected, Result).

-endif.
-endif.
