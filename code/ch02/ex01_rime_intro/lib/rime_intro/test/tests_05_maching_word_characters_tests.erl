-module(tests_05_maching_word_characters_tests).

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

maching_word_local_file_01_test() ->
    Expected = {match, ["T"]},
    InputString = read_local_file(),
    RegularExpression = "\\w",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

maching_word_01_test() ->
    Expected = true,
    % [a-z]
    InputList1 = lists:seq(97, 122),
    InputList = InputList1,
    RegularExpression = "\\w",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:all(fun(Elem) ->
                     NewString = [Elem],
                     {match, _} = re:run(NewString, MP),
                     true
                  end,
                  InputList),
    ?assertEqual(Expected, Result).

maching_word_02_test() ->
    Expected = true,
    % [a-z]
    InputList1 = lists:seq(97, 122),
    % [A-Z]
    InputList2 = lists:seq(65, 90),
    InputList = InputList1 ++ InputList2,
    RegularExpression = "\\w",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:all(fun(Elem) ->
                     NewString = [Elem],
                     {match, _} = re:run(NewString, MP),
                     true
                  end,
                  InputList),
    ?assertEqual(Expected, Result).

maching_word_03_test() ->
    Expected = true,
    % [a-z]
    InputList1 = lists:seq(97, 122),
    % [A-Z]
    InputList2 = lists:seq(65, 90),
    % [_]
    InputList3 = [$_],
    % [0-9]
    InputList4 = lists:seq(48, 57),
    InputList = InputList1 ++ InputList2 ++ InputList3 + InputList4,
    RegularExpression = "\\w",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:all(fun(Elem) ->
                     NewString = [Elem],
                     {match, _} = re:run(NewString, MP),
                     true
                  end,
                  InputList),
    ?assertEqual(Expected, Result).

maching_word_04_test() ->
    Expected = true,
    % [a-z]
    InputList1 = lists:seq(97, 122),
    % [A-Z]
    InputList2 = lists:seq(65, 90),
    % [_]
    InputList3 = [$_],
    InputList = InputList1 ++ InputList2 ++ InputList3,
    RegularExpression = "[_a-zA-Z0-9]",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:all(fun(Elem) ->
                     NewString = [Elem],
                     {match, _} = re:run(NewString, MP),
                     true
                  end,
                  InputList),
    ?assertEqual(Expected, Result).

-endif.
