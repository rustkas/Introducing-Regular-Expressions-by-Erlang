% For research For research mode, activate the RESEARCH constant.
%
-module(atomic_groups_01_tests).

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
    Regex = "(?>(?i)the)",
    {ok, MP} = re:compile(Regex),
    {match, Result} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    ?debugFmt("~p~n", [Result]).

-else.

alteration_test_() ->
    {foreach,
     local,
     fun read_rime/0,
     [fun research_01/1,
      fun research_02/1]}.

research_01(FileContent) ->
    Expected = 412,
    Regex = "(?>(?i)the)",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

research_02(FileContent) ->
    Expected = ["THE"],
    Regex = "(?>(?i)the)",
    {ok, MP} = re:compile(Regex),
    {match, Captured} =
        re:run(FileContent, MP, [notempty, global, {capture, all, list}]),
    Head = hd(Captured),
    Result = Head,
    ?_assertEqual(Expected, Result).



-endif.
-endif.
