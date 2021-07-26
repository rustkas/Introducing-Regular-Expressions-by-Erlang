% For research For research mode, activate the RESEARCH constant.
%
-module(number_of_times_tests).

%-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

read_local_file(FileName) ->
    {ok, Dir} = file:get_cwd(),
    FullFileName = Dir ++ [$/] ++ FileName,
    {ok, Binary} = file:read_file(FullFileName),
    String = unicode:characters_to_list(Binary, utf8),

    String.

read_triangle() ->
    String = read_local_file("triangle.txt"),
    String.

-ifdef(RESEARCH).

research_test() ->
    FileContent = read_triangle(),
    Regex = "7*",
    {ok, MP} = re:compile(Regex, [multiline]),
    {match, [Captured]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    %Count = length(Captured),
    %Result = Count,
    Result = Captured,
    ?debugFmt("Found! = ~p~n", [Result]).

-else.

triangle_test_() ->
    {foreach,
     local,
     fun read_triangle/0,
     [fun triangle_01/1,
      fun triangle_02/1,
      fun triangle_03/1,
      fun triangle_04/1,
      fun triangle_05/1,
      fun triangle_06/1,
      fun triangle_07/1]}.

triangle_01(FileContent) ->
    Expected = "7",
    Regex = "7{1}",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

triangle_02(FileContent) ->
    Expected = "7777777",
    Regex = "7{1,}",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

triangle_03(FileContent) ->
    Expected = "7777777",
    Regex = "7*",
    {ok, MP} = re:compile(Regex),
    {match, [Captured]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

triangle_04(FileContent) ->
    Expected = "7777777",
    Regex = "7{0,}",
    {ok, MP} = re:compile(Regex),
    {match, [Captured]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

triangle_05(FileContent) ->
    Expected = "7",
    Regex = "7?",
    {ok, MP} = re:compile(Regex),
    {match, [Captured]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

triangle_06(FileContent) ->
    Expected = "7",
    Regex = "7{0,1}",
    {ok, MP} = re:compile(Regex),
    {match, [Captured]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

triangle_07(FileContent) ->
    Expected = "77777",
    Regex = "7{3,5}",
    {ok, MP} = re:compile(Regex),
    {match, [Captured]} = re:run(FileContent, MP, [{capture, all, list}]),
    Result = Captured,
    ?_assertEqual(Expected, Result).

-endif.
-endif.
