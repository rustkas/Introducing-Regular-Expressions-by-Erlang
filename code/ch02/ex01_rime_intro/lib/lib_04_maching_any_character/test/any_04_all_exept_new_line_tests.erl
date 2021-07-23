% For research For research mode, activate the RESEARCH constant.
% .*
-module(any_04_all_exept_new_line_tests).

%-define(RESEARCH, true).
-define(REGEX, ".*").



%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").
   
read_local_file() ->
    FileName = "rime-intro.txt",
    {ok, Dir} = file:get_cwd(),
    FullFileName = Dir ++ [$/] ++ FileName,
    {ok, Binary} = file:read_file(FullFileName),
    String = binary_to_list(Binary),
    String.

-ifdef(RESEARCH).

research_test() ->
    FileContent = read_local_file(),

    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression,[]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?debugFmt("Found! = ~p~n", [Result]).

-else.

all_my_test_() ->
{foreach, local, fun read_local_file/0, [
 fun research_01/1, fun research_02/1, fun research_03/1, fun research_04/1, 
 fun research_05/1, fun research_06/1, fun research_07/1, fun research_08/1,
 fun research_09/1, fun research_10/1, fun research_11/1
]}.




research_01(FileContent) ->
    Expected = "THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.",
    
    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_02(FileContent) ->
    Expected = "THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.",
    
    RegularExpression = "[^\\n]*",
    {ok, MP} = re:compile(RegularExpression),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_03(FileContent) ->
    Expected = "\n",
    
    RegularExpression = "\\n",
    {ok, MP} = re:compile(RegularExpression),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).
	
research_04(FileContent) ->
    Expected = nomatch,
    
    RegularExpression = "\\n\\r",
    {ok, MP} = re:compile(RegularExpression),
    Result = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).	

research_05(FileContent) ->
    Expected = "THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.",
    
    RegularExpression = ".+",
    {ok, MP} = re:compile(RegularExpression),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_06(FileContent) ->
    Expected = "\n",
    
    RegularExpression = "\\xA", % line feed 
    {ok, MP} = re:compile(RegularExpression),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_07(FileContent) ->
    Expected = nomatch,
    
    RegularExpression = "\\xA\\xD", %  a line feed (U+000A), a carriage return (U+000D)
    {ok, MP} = re:compile(RegularExpression),
    Result = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_08(FileContent) ->
    Expected = 532,
    
    RegularExpression = ?REGEX, 
    {ok, MP} = re:compile(RegularExpression,[dotall]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
	Length = length(Result),
    ?_assertEqual(Expected, Length).

research_09(FileContent) ->
    Expected = 532,
    
    RegularExpression = ".+", 
    {ok, MP} = re:compile(RegularExpression,[dotall]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
	Length = length(Result),
    ?_assertEqual(Expected, Length).

research_10(FileContent) ->
    Expected = "THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.",
    
    RegularExpression = "^T.*$", 
    {ok, MP} = re:compile(RegularExpression,[multiline]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).
	
research_11(FileContent) ->
    Expected = "<h1>THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.</h1>",
    
    RegularExpression = "(^T.*$)", 
    {ok, MP} = re:compile(RegularExpression,[multiline]),

	{ok, Split_MP} = re:compile("\\n",[]),
    FullResult = re:replace(FileContent, MP, "<h1>\\1</h1>", [{return, list}]),
	ListOfLines = re:split(FullResult, Split_MP,[{return, list}]), 
	Result =  hd(ListOfLines),
	?_assertMatch("<h1>THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.</h1>", Result).
	
    
	
-endif.
-endif.
