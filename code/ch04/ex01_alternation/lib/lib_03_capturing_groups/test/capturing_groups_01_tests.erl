% For research For research mode, activate the RESEARCH constant.
%
-module(capturing_groups_01_tests).

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

read_rime() ->
    String = read_local_file("rime.txt"),
    String.

-ifdef(RESEARCH).

research_test() ->
    FileContent = read_rime(),
    Regex = "(It is) (an ancyent Marinere)",
    {ok, MP} = re:compile(Regex),
    Replacement = "\\2 \\1",
    Result = re:replace(FileContent, MP, Replacement, [{return, list}]),

    NewRegex = "an ancyent Marinere It is",
    {ok, NewMP} = re:compile(NewRegex),
    {match, NewResult} =
        re:run(Result, NewMP, [notempty, global, {capture, all, list}]),
    ?debugFmt("~p~n", [NewResult]).

-else.

alteration_test_() ->
    {foreach, local, fun read_rime/0, [fun research_01/1, fun research_02/1]}.

research_01(FileContent) ->
    Expected = "an ancyent Marinere It is",
    Regex = "(It is) (an ancyent Marinere)",
    {ok, MP} = re:compile(Regex),
    Replacement = "\\2 \\1",
    NewText = re:replace(FileContent, MP, Replacement, [{return, list}]),

    NewRegex = "an ancyent Marinere It is",
    {ok, NewMP} = re:compile(NewRegex),
    {match, [[Result]]} =
        re:run(NewText, NewMP, [notempty, global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

research_02(FileContent) ->
    Expected = "an ancyent Marinere It is",
    Regex = "(?<one>It is) (?<two>an ancyent Marinere)",
    {ok, MP} = re:compile(Regex),
    Replacement = "\\g{2} \\g{1}",
    re:replace(FileContent, MP, Replacement, [{return, list}]),
    NewText = re:replace(FileContent, MP, Replacement, [{return, list}]),
    ?debugFmt("~p~n", [NewText]),
    NewRegex = "an ancyent Marinere It is",
    {ok, NewMP} = re:compile(NewRegex),
    {match, [[Result]]} =
        re:run(NewText, NewMP, [notempty, global, {capture, all, list}]),
    ?_assertEqual(Expected, Result).

-endif.
-endif.
