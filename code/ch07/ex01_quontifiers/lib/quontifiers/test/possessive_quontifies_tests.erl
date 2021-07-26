% For research For research mode, activate the RESEARCH constant.
%
-module(possessive_quontifies_tests).

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
    Regex = "0{2,4}+",
    {ok, MP} = re:compile(Regex,[]),
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
     [
	 fun triangle_01/1,
	 fun triangle_02/1,
	 fun triangle_03/1,
	 fun triangle_04/1,
	 fun triangle_05/1,
	 fun triangle_06/1,
	 fun triangle_07/1,
	 fun triangle_08/1
	 ]}.


triangle_01(FileContent) ->
    Expected = "0000000000",
    Regex = "0.*+",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

triangle_02(FileContent) ->
    Expected = nomatch,
    Regex = ".*+0",
    {ok, MP} = re:compile(Regex),
    Result = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

triangle_03(FileContent) ->
    Expected = "0000000000",
    Regex = ".*0",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Possessive zero or one (optional)
triangle_04(FileContent) ->
    Expected = "0",
    Regex = "0?+",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Possessive one or more
triangle_05(FileContent) ->
    Expected = "0000000000",
    Regex = "0++",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Possessive zero or more
triangle_06(FileContent) ->
    Expected = "0000000000",
    Regex = "0*+",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Possessive n
triangle_07(FileContent) ->
    Expected = "00",
    Regex = "0{2}+",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    ?_assertEqual(Expected, Result).
	
% Possessive n or more
triangle_08(FileContent) ->
    Expected = "0000000000",
    Regex = "0{2,}+",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Possessive m,n
triangle_09(FileContent) ->
    Expected = "0000",
    Regex = "0{2,4}+",
    {ok, MP} = re:compile(Regex),
    {match, [Result]} = re:run(FileContent, MP, [notempty, {capture, all, list}]),
    ?_assertEqual(Expected, Result).
	
-endif.
-endif.
