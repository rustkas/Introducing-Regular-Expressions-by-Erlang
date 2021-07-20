% For research For research mode, activate the RESEARCH constant.
% .*
-module(line_01_beginning_end_tests).

%-define(RESEARCH, true).
-define(REGEX, "^THE.*\\?$").

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
    FileContent = read_local_file("rime_01.txt"),

    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression, [dotall]),
    {match, [Result]} = re:run([FileContent], MP, [{capture, all, list}]),
    ?debugFmt("Found! = ~p~n", [Result]).

-else.

read_rime() ->
    String = read_local_file("rime.txt"),
    String.

research_01_test() ->
    Expected =
        "How a Ship having passed the Line was driven by Storms to the cold Country towards the South Pole; and how from thence she made her course to the tropical Latitude of the Great Pacific Ocean; and of the strange things that befell; and in what manner the Ancyent Marinere came back to his own Country.",

    FileContent = read_rime(),
    RegularExpression = "^How.*Country\\.$",
    {ok, MP} = re:compile(RegularExpression, [dotall, multiline]),
    {match, [Result]} = re:run([FileContent], MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).

read_rime_01() ->
    String = read_local_file("rime_01.txt"),
    String.

research_02_test() ->
    Expected =
        "THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.\n\nARGUMENT.\n\nHow a Ship having passed the Line was driven by Storms to the cold Country towards the South Pole; and how from thence she made her course to the tropical Latitude of the Great Pacific Ocean; and of the strange things that befell; and in what manner the Ancyent Marinere came back to his own Country.\n\nI.\n\n     It is an ancyent Marinere,\n       And he stoppeth one of three:\n     \"By thy long grey beard and thy glittering eye\n
      \"Now wherefore stoppest me?",
    FileContent = read_rime_01(),
    RegularExpression = "^THE.*\\?$",
    {ok, MP} = re:compile(RegularExpression, [dotall]),
    {match, [Result]} = re:run([FileContent], MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).
	
research_03_test() ->
    Expected = nomatch,
    FileContent = read_rime_01(),
    RegularExpression = "^THE.*\\?$",
    {ok, MP} = re:compile(RegularExpression, []),
    Result = re:run([FileContent], MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).
	
research_04_test() ->
    Expected = "THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.",
    FileContent = read_rime_01(),
    RegularExpression = "^THE.*",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, [Result]} = re:run([FileContent], MP, [{capture, all, list}]),
    ?_assertEqual(Expected, Result).
	
research_05_test() ->
    Expected = 532,
    FileContent = read_rime_01(),
    RegularExpression = "^THE.*",
    {ok, MP} = re:compile(RegularExpression, []),
    {match, [ResultText]} = re:run([FileContent], MP, [{capture, all, list}]),
	ResultLength = length(ResultText),
    ?_assertEqual(Expected, ResultLength).	
	
-endif.
-endif.
