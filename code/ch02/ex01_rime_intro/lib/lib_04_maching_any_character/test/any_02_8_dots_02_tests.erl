% For research For research mode, activate the RESEARCH constant.
% .{8}
-module(any_02_8_dots_02_tests).

%-define(RESEARCH, true).
-define(REGEX, ".{8}").

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

letters_research_test() ->
    Expected = "THE RIME",
    FileContent = read_local_file(),

    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression),
    {match, [Result]} = re:run([FileContent], MP, [{capture, all, list}]),
    ?debugFmt("Found! = ~s~n", [Result]),
    ?assertEqual(Expected, Result).

-else.

research_01_test() ->
    Expected = "THE RIME",
    FileContent = read_local_file(),
    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression),
    {match, [Result]} = re:run([FileContent], MP, [{capture, all, list}]),
    ?assertEqual(Expected, Result).

-endif.
-endif.
