% For research For research mode, activate the RESEARCH constant.
%
-module(subpatterns_01_tests).%-define(RESEARCH, true).

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

-ifdef(RESEARCH).

research_test() ->
    FileContent = read_rime(),
    Regex = "\\b[tT]h[ceinry]*\\b",
    {ok, MP} = re:compile(Regex),
    {match, Result} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    %?debugFmt("~p~n", [length(Result)]).
    ?debugFmt("~p~n", [Result]).

-else.

alteration_test_() ->
    {foreach,
     local,
     fun read_rime/0,
     [fun research_01/1, fun research_02/1, fun research_03/1, fun research_04/1]}.

% Capture group of alternatives
research_01(FileContent) ->
    Expected = 410,
    Regex = "(t|T)h(e|eir)",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Capture alternatives
research_02(FileContent) ->
    Expected = 3,
    Regex = "Their",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Capture first
research_03(FileContent) ->
    Expected = 1982,
    Regex = "(e|eir)",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Capture first
research_04(FileContent) ->
    Expected = 396,
    Regex = "\\b[tT]h[ceinry]*\\b",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

-endif.
-endif.
