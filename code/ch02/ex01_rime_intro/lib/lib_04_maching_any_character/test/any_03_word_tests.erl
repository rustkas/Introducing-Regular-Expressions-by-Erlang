% For research For research mode, activate the RESEARCH constant.
% \bA.{5}T\b
-module(any_03_word_tests).

%-define(RESEARCH, true).
-define(REGEX, "\\bA.{5}T\\b").

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
    %?debugFmt("Binary = ~p~n", [String]).
    String.

-ifdef(RESEARCH).

research_test() ->
    Expected = "ANCYENT",
    FileContent = read_local_file(),

    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?debugFmt("Found! = ~s~n", [Result]),
    ?assertEqual(Expected, Result).

-else.

research_01_test() ->
    Expected = "ANCYENT",
    FileContent = read_local_file(),

    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression),
    {match, [Result]} = re:run(FileContent, MP, [{capture, all, list}]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
