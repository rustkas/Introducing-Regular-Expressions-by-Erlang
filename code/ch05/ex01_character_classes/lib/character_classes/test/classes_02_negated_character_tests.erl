% For research For research mode, activate the RESEARCH constant.
%
-module(classes_02_negated_character_tests).


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
FileContent = read_ascii_graphic(),
	Regex = "[a-z&&[^m-r]]",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
	
    ?debugFmt("~p~n", [Result]).
	

-else.

rime_test_() ->
    {foreach,
     local,
     fun read_rime/0,
     [fun rime_01/1]}.

read_ascii_graphic_test_() ->
    {foreach,
     local,
     fun read_ascii_graphic/0,
     [fun ascii_graphic_01/1]}.

rime_01(FileContent) ->
    Expected = 19987,
    Regex = "[^aeiou]",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

ascii_graphic_01(FileContent) ->
    Expected = 191,
    Regex = "[^aeiou]",
    {ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

-endif.
-endif.
