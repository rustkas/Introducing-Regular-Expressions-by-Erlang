% For research For research mode, activate the RESEARCH constant.
%
-module(number_of_times_tests).

-define(RESEARCH, true).

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
     [fun triangle_01/1
	 ]}.


triangle_01(FileContent) ->
    Expected = "1",
    Regex = "\\d",
    {ok, MP} = re:compile(Regex,[multiline,dotall]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

	
-endif.
-endif.
