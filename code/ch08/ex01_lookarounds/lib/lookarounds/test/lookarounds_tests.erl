% For research For research mode, activate the RESEARCH constant.
%
-module(lookarounds_tests).

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

read_rime() ->
    String = read_local_file("rime.txt"),
    String.

-ifdef(RESEARCH).

research_test() ->
    FileContent = read_rime(),
    Regex = "(?<!ancyent) marinere",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} = re:run(FileContent, MP, [global, {capture, all, list}]),
    Result = Captured,
    ?debugFmt("Found! = ~p~n", [Result]).

-else.

rime_test_() ->
    {foreach,
     local,
     fun read_rime/0,
     [fun rime_01/1,
      fun rime_02/1,
      fun rime_03/1,
      fun rime_04/1,
      fun rime_05/1,
      fun rime_06/1]}.

% Positive lookahead
rime_01(FileContent) ->
    Expected = 5,
    Regex = "(?i)ancyent (?=marinere)",
    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(FileContent, MP, [global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Positive lookahead
rime_02(FileContent) ->
    Expected = 7,
    Regex = "(?i)ancyent (?=m)",
    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(FileContent, MP, [global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Positive lookahead
rime_03(FileContent) ->
    Expected = 7,
    Regex = "ancyent (?=ma)",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} = re:run(FileContent, MP, [global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Negative lookahead
rime_04(FileContent) ->
    Expected = 2,
    Regex = "ancyent (?!marinere)",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} = re:run(FileContent, MP, [global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Positive lookbehind
rime_05(FileContent) ->
    Expected = 5,
    Regex = "(?<=ancyent) marinere",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} = re:run(FileContent, MP, [global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Negative lookbehind
rime_06(FileContent) ->
    Expected = 12,
    Regex = "(?<!ancyent) marinere",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} = re:run(FileContent, MP, [global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

-endif.
-endif.
