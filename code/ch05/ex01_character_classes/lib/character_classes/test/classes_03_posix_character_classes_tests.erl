% For research For research mode, activate the RESEARCH constant.
%
-module(classes_03_posix_character_classes_tests).
-export([read_rime/0, read_ascii_graphic/0, write_to_file/2]).

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

write_to_file(String,FileName) ->
    {ok, Dir} = file:get_cwd(),
    FullFileName = Dir ++ [$/] ++ FileName++".txt",
	Binary = list_to_binary(String),
    file:write_file(FullFileName,Binary).   

read_rime() ->
    String = read_local_file("rime.txt"),
    String.

read_ascii_graphic() ->
    String = read_local_file("ascii-graphic.txt"),
    String.

-ifdef(RESEARCH).

research_test() ->
FileContent = read_rime(),
	Regex = "[[:graph:]]",
	RegexTune = Regex,	
    {ok, MP} = re:compile(RegexTune),
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
     [fun rime_01/1,
	  fun rime_02/1,
	  fun rime_03/1,
	  fun rime_04/1,
	  fun rime_05/1,
	  fun rime_06/1,
	  fun rime_07/1,
	  fun rime_08/1,
	  fun rime_09/1,
	  fun rime_10/1,
	  fun rime_11/1,
	  fun rime_12/1,
	  fun rime_13/1
	  ]}.

read_ascii_graphic_test_() ->
    {foreach,
     local,
     fun read_ascii_graphic/0,
     [fun ascii_graphic_01/1,
	  fun ascii_graphic_02/1
	 ]}.

rime_01(FileContent) ->
    Expected = 16185,
    Regex = "[[:alnum:]]",
	RegexTune = re_tuner:tune(Regex),	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

rime_02(FileContent) ->
    Expected = 16185,
    Regex = "[[:alpha:]]",
	RegexTune = re_tuner:tune(Regex),	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

rime_03(FileContent) ->
    Expected = 25479,
    Regex = "[[:ascii:]]",
	RegexTune = re_tuner:tune(Regex),	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).
	
rime_04(FileContent) ->
    Expected = 9294,
    Regex = "[[:^alpha:]]",
	RegexTune = re_tuner:tune(Regex),	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).	

rime_05(FileContent) ->
    Expected = 8211,
    Regex = "[[:space:]]",
	RegexTune = re_tuner:tune(Regex),	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).
	
rime_06(FileContent) ->
    Expected = 7378,
    Regex = "[[:blank:]]",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).
	
rime_07(FileContent) ->
    Expected = 833,
    Regex = "[[:cntrl:]]",
    RegexTune = re_tuner:tune(Regex),	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).	
	
rime_08(FileContent) ->
    Expected = 15184,
    Regex = "[[:lower:]]",
    RegexTune = re_tuner:tune(Regex),	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).	
	
rime_09(FileContent) ->
    Expected = 1003,
    Regex = "[[:upper:]]",
	RegexTune = Regex,	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).	

rime_10(FileContent) ->
    Expected = 17272,
    Regex = "[[:graph:]]",
    RegexTune = Regex,	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

rime_11(FileContent) ->
    Expected =  16199,
    Regex = "[[:word:]]",
    RegexTune = Regex,	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).
	
rime_12(FileContent) ->
    Expected = 24650,
    Regex = "[[:print:]]",
    RegexTune = Regex,	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).	

rime_13(FileContent) ->
    Expected = 1085,
    Regex = "[[:punct:]]",
    RegexTune = Regex,	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).
	
ascii_graphic_01(FileContent) ->
    Expected = 62,
    RegexInput = "[[:alnum:]]",
	Regex = re_tuner:tune(RegexInput),
	{ok, MP} = re:compile(Regex),
    {match, Captured} = re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

ascii_graphic_02(FileContent) ->
    Expected = 10,
    Regex = "[[:digit:]]",
    RegexTune = re_tuner:tune(Regex),	
    {ok, MP} = re:compile(RegexTune),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

-endif.
-endif.
