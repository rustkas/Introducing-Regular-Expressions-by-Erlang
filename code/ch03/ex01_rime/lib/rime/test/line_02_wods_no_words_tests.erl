% For research For research mode, activate the RESEARCH constant.
% 
-module(line_02_wods_no_words_tests).

-define(RESEARCH, true).
-define(REGEX, "\\b").

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
    {match, Result} = re:run([FileContent], MP, [global, {capture, all, list}]),
    ?debugFmt("Found! = ~p~n", [Result]).

-else.

read_rime() ->
    String = read_local_file("rime.txt"),
    String.

research_01_test() ->
    Expected = [["THE"], ["THE"]],
    FileContent = read_rime(),
    RegularExpression = "\\bTHE\\b",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, Result} = re:run([FileContent], MP, [global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_02_test() ->
    Expected = 3206,
    FileContent = read_rime(),
    RegularExpression = "\\b \\b",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, Result} = re:run([FileContent], MP, [global, {capture, all, list}]),
	SpaceCount = length(Result),
    ?_assertEqual(Expected, SpaceCount).
	
-endif.
-endif.
