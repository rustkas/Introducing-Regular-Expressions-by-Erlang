% For research For research mode, activate the RESEARCH constant.
%
-module(line_03_add_tags_tests).

%-define(RESEARCH, true).
-define(REGEX, "^(.*)$").

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

get_tags() -> "<!DOCTYPE html>\n<html lang=\"en\">\n<head><title>Rime</title></head>\n<body>\n<h1>\\1</h1>".

-ifdef(RESEARCH).

research_test() ->
    FileContent = read_local_file("rime_01.txt"),
    {ok, MP} = re:compile(?REGEX,[multiline]),
    Tags = get_tags(),
    Result = re:replace(FileContent, MP, Tags, [{return, list}]),
    ?debugFmt("~p~n", [Result]).

-else.

replace_01_test() ->
    Expected = "<",
	FileContent = read_local_file("rime_01.txt"),
    {ok, MP} = re:compile(?REGEX,[multiline]),
    Tags = get_tags(),
    NewString = re:replace(FileContent, MP, Tags, [{return, list}]),
	Result = string:left(NewString,1),
	?assertEqual(Expected,Result).
	
-endif.
-endif.
