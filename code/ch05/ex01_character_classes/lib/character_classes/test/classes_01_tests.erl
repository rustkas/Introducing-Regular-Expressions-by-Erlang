% For research For research mode, activate the RESEARCH constant.
%
-module(classes_01_tests).

-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

read_local_file(FileName) ->
    {ok, Dir} = file:get_cwd(),
    FullFileName = Dir ++ [$/] ++ FileName,
    {ok, Binary} = file:read_file(FullFileName),
    String = binary_to_list(Binary),
    String.

read_rime() ->
    String = read_local_file("rime.txt"),
    String.

read_ascii_graphic() ->
    String = read_local_file("ascii-graphic.txt"),
    String.

-ifdef(RESEARCH).

research_test() ->
    Regex = "[a-fA-F0-9]+",
    {ok, MP} = re:compile(Regex),
    ListNumbers =
        lists:map(fun(Elem) -> sstr:integer_to_list(Elem,16) end, lists:seq(0, 99)),
    Content = sstr:join(ListNumbers, " "),
    %?debugFmt("~p~n", [Content])
	{match, Captured} =
        re:run(Content, MP, [notempty, global, {capture, all, list}]),
    ?debugFmt("~p~n", [Captured]).

-else.

rime_test_() ->
    {foreach,
     local,
     fun read_rime/0,
     [fun research_01/1, fun research_02/1, fun research_03/1]}.

read_ascii_graphic_test_() ->
    {foreach,
     local,
     fun read_ascii_graphic/0,
     [fun research_04/1, fun research_05/1]}.

research_01(FileContent) ->
    Expected = 5496,
    Regex = "[aeiou]",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

research_02(FileContent) ->
    Expected = 15184,
    Regex = "[a-z]",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

research_03(FileContent) ->
    Expected = nomatch,
    Regex = "[0-9]",
    {ok, MP} = re:compile(Regex),
    Result = re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_04(FileContent) ->
    Expected = 10,
    Regex = "[0-9]",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

research_05(FileContent) ->
    Expected = 4,
    Regex = "[3-6]",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% even numbers in the range 0 through 19
research_06_test() ->
    Expected = 5,
    Regex = "\\b[1][24680]",
    {ok, MP} = re:compile(Regex),
    ListNumbers =
        lists:map(fun(Elem) -> sstr:integer_to_list(Elem) end, lists:seq(10, 19)),
    Content = sstr:join(ListNumbers, " "),
    {match, Captured} =
        re:run(Content, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?assertEqual(Expected, Result).

% even numbers in the range 0 through 99
research_07_test() ->
    Expected = 50,
    Regex = "\\b[24680]\\b|\\b[1-9][24680]\\b",
    {ok, MP} = re:compile(Regex),
    ListNumbers =
        lists:map(fun(Elem) -> sstr:integer_to_list(Elem) end, lists:seq(0, 99)),
    Content = sstr:join(ListNumbers, " "),
    {match, Captured} =
        re:run(Content, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
	%?debugFmt("Expected = ~p, Result = ~p~n",[Expected,Result]),
    ?assertEqual(Expected, Result).

research_0_test() ->
    Expected = 50,
    Regex = "[a-fA-F0-9]",
    {ok, MP} = re:compile(Regex),
    ListNumbers =
        lists:map(fun(Elem) -> sstr:integer_to_list(Elem,16) end, lists:seq(0, 99)),
    Content = sstr:join(ListNumbers, " "),
    {match, Captured} =
        re:run(Content, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
	%?debugFmt("Expected = ~p, Result = ~p~n",[Expected,Result]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
