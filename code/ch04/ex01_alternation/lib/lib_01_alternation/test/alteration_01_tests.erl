% For research For research mode, activate the RESEARCH constant.
%
-module(alteration_01_tests).%-define(RESEARCH, true).

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

-ifdef(RESEARCH).

research_test() ->
    FileContent = read_local_file("rime.txt"),
    Regex = "(?)the",
    %Regex = "the",
    {ok, MP} = re:compile(Regex),
    {match, Result} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    ?debugFmt("~p~n", [length(Result)]).

-else.

read_rime() ->
    String = read_local_file("rime.txt"),
    String.

alteration_test_() ->
    {foreach,
     local,
     fun read_rime/0,
     [fun research_01/1,
      fun research_02/1,
      fun research_03/1,
      fun research_04/1,
      fun research_05/1,
      fun research_06/1,
      fun research_07/1]}.

% Capture group of alternatives
research_01(FileContent) ->
    Expected = 412,
    Regex = "(the|The|THE)",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, first, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Capture alternatives
research_02(FileContent) ->
    Expected = 412,
    Regex = "the|The|THE",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, first, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Capture first
research_03(FileContent) ->
    Expected = ["THE", "THE"],
    Regex = "(the|The|THE)",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Head = hd(Captured),
    Result = Head,
    ?_assertEqual(Expected, Result).

% Capture first
research_04(FileContent) ->
    Expected = ["THE"],
    Regex = "the|The|THE",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Head = hd(Captured),
    Result = Head,
    ?_assertEqual(Expected, Result).

%Capture ignore case
research_05(FileContent) ->
    Expected = 412,
    Regex = "the",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

%Capture ignore case
research_06(FileContent) ->
    Expected = 412,
    Regex = "The",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

%Capture ignore case
research_07(FileContent) ->
    Expected = 412,
    Regex = "THE",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

-endif.
-endif.
