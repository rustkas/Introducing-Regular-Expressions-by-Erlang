% For research For research mode, activate the RESEARCH constant.
%
-module(line_02_words_no_words_boundaries_tests).

%-define(RESEARCH, true).
-define(REGEX, "morn.?\\Z").

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

    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression, []),
    {match, Result} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    ?debugFmt("Found! = ~p~n", [Result]).

-else.

read_rime() ->
    String = read_local_file("rime.txt"),
    String.

rime_test_() ->
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

% find words THE
research_01(FileContent) ->
    Expected = [["THE"], ["THE"]],
    RegularExpression = "\\bTHE\\b",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, Result} = re:run(FileContent, MP, [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

% find a space count
research_02(FileContent) ->
    Expected = 3206,
    RegularExpression = "\\b \\b",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, Result} = re:run(FileContent, MP, [global, {capture, all, list}]),
    SpaceCount = length(Result),
    ?_assertEqual(Expected, SpaceCount).

% find character inside a word
research_03(FileContent) ->
    Expected = 1032,
    RegularExpression = "\\Be\\B",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, Result} = re:run(FileContent, MP, [global, {capture, all, list}]),
    CharacterCount = length(Result),
    ?_assertEqual(Expected, CharacterCount).

% calculate words "THE, The, the" count
research_04(FileContent) ->
    Expected = 307,
    RegularExpression = "\\b(THE|The|the)\\b",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, Result} = re:run(FileContent, MP, [global, {capture, all, list}]),
    CharacterCount = length(Result),
    ?_assertEqual(Expected, CharacterCount).

% match the first line
research_05(FileContent) ->
    Expected = "THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.",
    RegularExpression = "\\A.*",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, [[Result]]} = re:run(FileContent, MP, [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

% match the last line
research_06(FileContent) ->
    Expected = "       He rose the morrow morn.",
    RegularExpression = ".*\\Z",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, [[Result]]} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

% match the last word
research_07(FileContent) ->
    Expected = "morn.",
    RegularExpression = "morn.*\\Z",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, [[Result]]} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
