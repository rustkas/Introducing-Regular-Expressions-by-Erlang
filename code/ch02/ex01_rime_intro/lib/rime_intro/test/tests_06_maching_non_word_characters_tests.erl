-module(tests_06_maching_non_word_characters_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

read_local_file() ->
    FileName = "rime-intro.txt",
    {ok, Dir} = file:get_cwd(),
    FullFileName = Dir ++ [$/] ++ FileName,
    {ok, Binary} = file:read_file(FullFileName),
    String = binary_to_list(Binary),
    %?debugFmt("Binary = ~p~n", [String]).
    String.

maching_word_non_local_file_01_test() ->
    Expected = {match, [" "]},
    InputString = read_local_file(),
    RegularExpression = "\\W",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

% Helper
create_non_word_character_list_for_remove() ->
    InputList1 = lists:seq(97, 122),
    % [A-Z]
    InputList2 = lists:seq(65, 90),
    % [_]
    InputList3 = [$_],
    % [0-9]
    InputList4 = lists:seq(48, 57),

    InputList5 = [170, 181, 186] ++ lists:seq(192, 255),
    WordCharacterList =
        InputList1 ++ InputList2 ++ InputList3 ++ InputList4 ++ InputList5,
    WordCharacterList.

create_non_word_character_list() ->
    WordCharacterList = create_non_word_character_list_for_remove(),
    NonWordCharacterList = lists:seq(0, 255) -- WordCharacterList,
    NonWordCharacterList.

maching_non_word_list_01_test() ->
    Expected = true,
    NonWordCharacterList = create_non_word_character_list(),
    RegularExpression = "\\W",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:all(fun(Elem) ->
                     NewString = [Elem],
                     %?debugFmt("Current Element = ~p~n", [Elem]),
                     {match, _} = re:run(NewString, MP),
                     true
                  end,
                  NonWordCharacterList),
    ?assertEqual(Expected, Result).

maching_non_word_list_02_test() ->
    Expected = true,
    NonWordCharacterList = create_non_word_character_list(),
    RegularExpression = "[^_a-zA-Z0-9]",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:all(fun(Elem) ->
                     NewString = [Elem],
                     %?debugFmt("Current Element = ~p~n", [Elem]),
                     {match, _} = re:run(NewString, MP),
                     true
                  end,
                  NonWordCharacterList),
    ?assertEqual(Expected, Result).

-endif.
