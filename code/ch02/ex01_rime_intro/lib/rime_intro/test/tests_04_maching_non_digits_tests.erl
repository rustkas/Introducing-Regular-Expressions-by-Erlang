-module(tests_04_maching_non_digits_tests).

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

maching_non_digits_local_file_01_test() ->
    Expected = {match, ["T"]},
    InputString = read_local_file(),
    RegularExpression = "\\D",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

maching_non_digits_local_file_02_test() ->
    Expected = ["T"],
    InputString = read_local_file(),
    RegularExpression = "\\D",
    {ok, MP} = re:compile(RegularExpression),
    {match, [Expected | _]} =
        re:run(InputString, MP, [global, {capture, all, list}]).

maching_non_digits_local_file_03_test() ->
    Expected = {match, ["T"]},
    InputString = read_local_file(),
    RegularExpression = "[^0-9]",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

maching_non_digits_local_file_04_test() ->
    Expected = {match, ["T"]},
    InputString = read_local_file(),
    RegularExpression = "[^\\d]",
    {ok, MP} = re:compile(RegularExpression),
    Expected = re:run(InputString, MP, [{capture, all, list}]).

maching_non_digits_list_01_test() ->
    Expected = true,
    % [a-z]
    InputList1 = lists:seq(97, 122),
    %?debugFmt("~p~n",[InputList1]),
    RegularExpression = "\\D",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:all(fun(Elem) ->
                     NewString = [Elem],
                     {match, _} = re:run(NewString, MP),
                     true
                  end,
                  InputList1),
    ?assertEqual(Expected, Result).

maching_non_digits_list_02_test() ->
    Expected = true,
    % [A-Z]
    InputList1 = lists:seq(65, 90),
    %?debugFmt("~p~n",[InputList1]),
    RegularExpression = "\\D",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:all(fun(Elem) ->
                     NewString = [Elem],
                     {match, _} = re:run(NewString, MP),
                     true
                  end,
                  InputList1),
    ?assertEqual(Expected, Result).

maching_non_digits_list_03_test() ->
    Expected = true,
    % select all ASCII characters except numbers
    InputList1 = lists:seq(0, 255) -- lists:seq(48, 57),
    %?debugFmt("~p~n",[InputList1]),
    RegularExpression = "\\D",
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:all(fun(Elem) ->
                     NewString = [Elem],
                     {match, _} = re:run(NewString, MP),
                     true
                  end,
                  InputList1),
    ?assertEqual(Expected, Result).

-endif.
