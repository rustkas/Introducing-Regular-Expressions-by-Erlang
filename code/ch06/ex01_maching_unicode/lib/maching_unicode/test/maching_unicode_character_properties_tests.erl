% For research For research mode, activate the RESEARCH constant.
%
-module(maching_unicode_character_properties_tests).

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

read_schiller() ->
    String = read_local_file("schiller.txt"),
    String.

-ifdef(RESEARCH).

research_test() ->
    FileContent = read_schiller(),
    Regex = "\\Cf",
    %?debugFmt("FileContent = ~ts~n", [FileContent]),
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?debugFmt("Found! = ~i~n", [hd(Result)]).

-else.

schiller_test_() ->
    {foreach,
     local,
     fun read_schiller/0,
     [fun schiller_01/1,
      fun schiller_02/1,
      fun schiller_03/1,
      fun schiller_04/1,
      fun schiller_05/1,
      fun schiller_06/1,
      fun schiller_07/1,
      fun schiller_08/1,
      fun schiller_09/1]}.

% Find a letter
schiller_01(FileContent) ->
    Expected = "A",
    Regex = "\\pL",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Find lower case letter
schiller_02(FileContent) ->
    Expected = "n",
    Regex = "\\p{Ll}",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Find upper case letter
schiller_03(FileContent) ->
    Expected = "A",
    Regex = "\\p{Lu}",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Find non letter
schiller_04(FileContent) ->
    Expected = " ",
    Regex = "\\PL",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Find non letter
schiller_05(FileContent) ->
    Expected = "A",
    Regex = "\\P{Ll}",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Find non letter
schiller_06(FileContent) ->
    Expected = "n",
    Regex = "\\P{Lu}",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

% Find other
schiller_07(FileContent) ->
    Expected = "A",
    Regex = "\\C",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

        % Find other

schiller_08(FileContent) ->
    Expected = "sc",
    Regex = "\\Cc",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

schiller_09(FileContent) ->
    Expected = "rf",
    Regex = "\\Cf",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
