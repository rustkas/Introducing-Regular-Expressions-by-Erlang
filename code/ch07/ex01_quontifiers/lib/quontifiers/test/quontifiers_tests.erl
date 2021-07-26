% For research For research mode, activate the RESEARCH constant.
%
-module(quontifiers_tests).

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
    Regex = "99?",
    {ok, MP} = re:compile(Regex,[multiline,dotall]),
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
	  fun triangle_07/1,
	  fun triangle_08/1
	 ]}.


triangle_01(FileContent) ->
    Expected = "1",
    Regex = "\\d",
    {ok, MP} = re:compile(Regex,[multiline,dotall]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

triangle_02(FileContent) ->
    Expected = "1",
    Regex = "\\d",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

triangle_03(FileContent) ->
    Expected = 65,
    Regex = ".*",
    {ok, MP} = re:compile(Regex,[multiline,dotall]),
    {match, [Captured]} = re:run(FileContent, MP, [{capture, all, list}]),
	Count = length(Captured),
	Result = Count, 
    ?_assertEqual(Expected, Result).

triangle_04(FileContent) ->
    Expected = "9",
    Regex = "9",
    {ok, MP} = re:compile(Regex,[multiline,dotall]),
    {match, [Captured]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
	Result = Captured, 
    ?_assertEqual(Expected, Result).

triangle_05(FileContent) ->
    Expected = "999999999",
    Regex = "9*",
    {ok, MP} = re:compile(Regex,[multiline,dotall]),
    {match, [Captured]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
	Result = Captured, 
    ?_assertEqual(Expected, Result).
	
triangle_06(FileContent) ->
    Expected = "999999999\n" "0000000000\n",
    Regex = "9.*",
    {ok, MP} = re:compile(Regex,[multiline,dotall]),
    {match, [Captured]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
	Result = Captured, 
    ?_assertEqual(Expected, Result).	

triangle_07(FileContent) ->
    Expected = "9",
    Regex = "9?",
    {ok, MP} = re:compile(Regex,[multiline,dotall]),
    {match, [Captured]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
	Result = Captured, 
    ?_assertEqual(Expected, Result).

triangle_08(FileContent) ->
    Expected = "99",
    Regex = "99?",
    {ok, MP} = re:compile(Regex,[multiline,dotall]),
    {match, [Captured]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
	Result = Captured, 
    ?_assertEqual(Expected, Result).
	
-endif.
-endif.
