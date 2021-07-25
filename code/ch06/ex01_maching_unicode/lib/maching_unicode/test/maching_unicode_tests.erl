-module(maching_unicode_tests).
-export([read_voltaire/0,read_basho/0]).

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
	String = unicode:characters_to_list(Binary, utf8 ),
	
    String.
	
read_voltaire() ->
    String = read_local_file("voltaire.txt"),
    String.	

read_basho() ->
    String = read_local_file("basho.txt"),
    String.	

-ifdef(RESEARCH).

research_test() ->
    
    FileContent = read_basho(),
    Regex = "\\x{2014}",
	%?debugFmt("FileContent = ~ts~n", [FileContent]),
	{ok, MP} = re:compile(Regex,[unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?debugFmt("Found! = ~ts~n", [Result]).
    

-else.

voltaire_test_() ->
    {foreach,
     local,
     fun read_voltaire/0,
     [fun voltaire_01/1,
	  fun voltaire_02/1,
	  fun voltaire_03/1
	  ]}.

basho_test_() ->
    {foreach,
     local,
     fun read_basho/0,
     [fun basho_01/1,
	 fun basho_02/1,
	 fun basho_03/1,
	 fun basho_04/1
	  ]}.

voltaire_01(FileContent) ->
    Expected = "é",
    Regex = "é",
    {ok, MP} = re:compile(Regex,[unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

voltaire_02(FileContent) ->
    Expected = "é",
    Regex = "\\xE9",
    {ok, MP} = re:compile(Regex,[unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

voltaire_03(FileContent) ->
    Expected = "é",
    Regex = "\\xe9",
    {ok, MP} = re:compile(Regex,[unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

basho_01(FileContent) ->
    Expected = "池",
	Regex = "池",
	{ok, MP} = re:compile(Regex,[unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
	?_assertEqual(Expected, Result).

basho_02(FileContent) ->
    Expected = "池",
	Regex = "\\x{6C60}",
	{ok, MP} = re:compile(Regex,[unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
	?_assertEqual(Expected, Result).	

basho_03(FileContent) ->
    Expected = "—",
	Regex = "—",
	{ok, MP} = re:compile(Regex,[unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
	?_assertEqual(Expected, Result).

basho_04(FileContent) ->
    Expected = "—",
	Regex = "\\x{2014}",
	{ok, MP} = re:compile(Regex,[unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
	?_assertEqual(Expected, Result).
	
-endif.
-endif.
