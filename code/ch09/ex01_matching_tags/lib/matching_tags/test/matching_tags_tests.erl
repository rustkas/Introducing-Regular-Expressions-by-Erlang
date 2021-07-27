% For research For research mode, activate the RESEARCH constant.
%
-module(matching_tags_tests).

-export([read_rime/0, read_lorem/0]).

-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

file_path(FileName) ->
    {ok, Dir} = file:get_cwd(),
    FullFileName = Dir ++ [$/] ++ FileName,
    FullFileName.

read_local_file(FileName) ->
    FullFileName = file_path(FileName),
    {ok, Binary} = file:read_file(FullFileName),
    String = unicode:characters_to_list(Binary, utf8),
    String.

read_rime() ->
    String = read_local_file("rime.txt"),
    String.

read_lorem() ->
    String = read_local_file("lorem.dita"),
    String.

-ifdef(RESEARCH).

research_test() ->
    FileContent = read_rime(),
    Regex = "(^.*$)",
    
    Markup =
        "
\t<!DOCTYPE html>\n
    <html lang=\"en\">\n
\t	\t<head>\n
\t		\t\t<title>&</title>\n
\t		\t\t<meta charset=\"utf-8\"/>\n
    </head>\n
\t<body>\n
<h1>&<\h1>
\t",
    NewContent =
        re:replace(FileContent, Regex, Markup, [multiline,{return, list}]),
?debugFmt("NewContent = ~p~n", [NewContent]).

-else.

lorem_test_() ->
    {foreach,
     local,
     fun read_lorem/0,
     [
	 fun lorem_01/1, 
	 fun lorem_02/1, fun add_markup/1]}.

rime_test_() ->
    {foreach, local, fun read_rime/0, 
	[
	fun make_title/1,
	fun insert_title/1
	
	]}.

% Start-tags
lorem_01(FileContent) ->
    Expected = 11,
    Regex = "<[_a-zA-Z][^>]*>",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} = re:run(FileContent, MP, [global, {capture, all, list}]),

    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

% Start-tags and End-tags
lorem_02(FileContent) ->
    Expected = 22,
    Regex = "</?[_a-zA-Z][^>]*>",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} = re:run(FileContent, MP, [global, {capture, all, list}]),
    Count = length(Captured),
    Result = Count,
    ?_assertEqual(Expected, Result).

lorem_03(FileContent) ->
    Expected = ["body", "li", "p", "title", "topic", "ul"],
    Regex = "(?<=<)[_a-zA-Z][^>]*(?= id=\\x22.*\\x22>)|(?<=<)[_a-zA-Z][^>]*(?=>)",
    {ok, MP} = re:compile(Regex, [caseless]),
    {match, Captured} = re:run(FileContent, MP, [global, {capture, all, list}]),
    UniuqueItemsList =
        [X
         || {[X], _}
                <- dict:to_list(
                       lists:foldl(fun(X, Acc) -> dict:update_counter(X, 1, Acc) end,
                                   dict:new(),
                                   Captured))],
    SortedList = lists:sort(fun(A, B) -> A =< B end, UniuqueItemsList),
    Result = SortedList,
    ?_assertEqual(Expected, Result).

add_markup(FileContent) ->
    FileContent = read_lorem(),
    Expected = ok,
    Markup =
        "
\t<!DOCTYPE html>\n
    <html lang=\"en\">\n
\t	\t<head>\n
\t		\t\t<title>The Rime of the Ancyent Marinere (1798)</title>\n
\t		\t\t<meta charset=\"utf-8\"/>\n
    </head>\n
\t<body>\n
\t",
    FilePath = file_path("rime.txt"),
    DirName = filename:dirname(FilePath),
    NewFileName = "markuped_rime.txt",
    NewFilePath = file_path(NewFileName),

    NewContent = Markup ++ FileContent,
    Result = file:write_file(NewFilePath, NewContent),
    ?_assertEqual(Expected, Result).

make_title(FileContent) ->
    Expected = "<title>THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.</title>",
    Regex = "^.*$",
    {ok, MP} = re:compile(Regex, [multiline]),
    {match, [Captured]} = re:run(FileContent, MP, [{capture, all, list}]),
    ResultTitle = sstr:concat(["<title>", Captured, "</title>"]),
    ?_assertEqual(Expected, ResultTitle).

insert_title(FileContent) ->
    Regex = "(^.*$)",
    Expected = 2,
    {ok, MP} = re:compile(Regex, [multiline]),
    {match, [Captured]} = re:run(FileContent, MP, [{capture, first, list}]),

Markup =
        "
\t<!DOCTYPE html>\n
    <html lang=\"en\">\n
\t	\t<head>\n
\t		\t\t<title>&</title>\n
\t		\t\t<meta charset=\"utf-8\"/>\n
    </head>\n
\t<body>\n
<h1>&<\h1>
\t",
    NewContent =
        re:replace(FileContent, Regex, Markup, [global,{return, list}]),
    RegexString = Captured,
    {ok, MP_String} = re:compile(RegexString, [multiline]),
    {match, CapturedStringList} =
        re:run(NewContent, MP_String, [global, {capture, all, list}]),
    Length = length(CapturedStringList),
    Result = Length,
    ?_assertEqual(Expected, Result).



add_h2(FileContent)->
    Expected = 10,
    
	Regex = "(^(ARGUMENT\\.|I{0,3}V?I{0,2}\\.)$)",
    Markup = "<h2>&</h2>",
NewContent =
        re:replace(FileContent, Regex, Markup, [global, {return, list}]),
?debugFmt("NewContent = ~p~n", [NewContent]),
RegexMarkup = "<h2>.+</h2>",
{ok, MP} = re:compile(RegexMarkup, [multiline]),
{match, Captured} = re:run(NewContent, MP, [global, {capture, all, list}]),
?debugFmt("Captured = ~p~n", [Captured]),
    Length = length(Captured),
    Result = Length,
	?_assertEqual(Expected, Result).

-endif.
-endif.
