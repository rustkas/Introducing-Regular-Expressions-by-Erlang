% For research For research mode, activate the RESEARCH constant.
%
-module(matching_tags_tests).

-export([read_rime/0, read_lorem/0]).

%-define(RESEARCH, true).

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
    Regex = "(^([ ]*)(He rose the morrow morn.)$)",
    Markup = "&</body></html>",
    NewContent =
        re:replace(FileContent,
                   Regex,
                   Markup,
                   [multiline, global, dollar_endonly, {return, list}]),
    RegexMarkup = "</body></html>",
    {ok, MP} = re:compile(RegexMarkup),
    {match, Captured} = re:run(NewContent, MP, [global, {capture, first, list}]),
    Length = length(Captured),
    _Result = Length,
    ?debugFmt("Result = ~p~n", [NewContent]).

-else.

lorem_test_() ->
    {foreach,
     local,
     fun read_lorem/0,
     [fun lorem_01/1, fun lorem_02/1, fun lorem_03/1]}.

rime_test_() ->
    {foreach,
     local,
     fun read_rime/0,
     [fun converter/1,
      fun make_title/1,
      fun insert_title/1,
      fun add_h2/1,
      fun add_markup/1,
      fun mark_specific_paragraph/1,
      fun start_paragraph/1,
      fun add_br/1,
      fun end_paragraph/1,
      fun replace_emtpy_lines/1,
      fun add_end_tags/1]}.

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

% Transforming Plain Text with sed
add_markup(FileContent) ->
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

    NewFileName = "markuped_rime.txt",
    NewFilePath = file_path(NewFileName),

    NewContent = Markup ++ FileContent,
    Result = file:write_file(NewFilePath, NewContent),
    ?_assertEqual(Expected, Result).

% Substitution with sed
make_title(FileContent) ->
    Expected = "<title>THE RIME OF THE ANCYENT MARINERE, IN SEVEN PARTS.</title>",
    Regex = "^.*$",
    {ok, MP} = re:compile(Regex, [multiline]),
    {match, [Captured]} = re:run(FileContent, MP, [{capture, all, list}]),
    ResultTitle = sstr:concat(["<title>", Captured, "</title>"]),
    ?_assertEqual(Expected, ResultTitle).

converter(FileContent) ->
    Expected = ok,
    InsertHead =
        fun(String) ->
           Regex = "(^.*$)",
           Markup =
               "<!DOCTYPE html>
<html lang=\"en\">
<head>
   <title>&</title>
      <meta charset=\"utf-8\"/>
</head>
<body>
<h1>&<\h1>
",
           NewContent = re:replace(String, Regex, Markup, [multiline, {return, list}]),
           NewContent
        end,

    Add_h2 =
        fun(String) ->
           Regex = "(^(ARGUMENT\\.|I{0,3}V?I{0,2}\\.)$)",
           Markup = "<h2>&</h2>",
           NewContent =
               re:replace(String, Regex, Markup, [multiline, global, {return, list}]),
           NewContent
        end,
    MarkSpecificParagraph =
        fun(String) ->
           Regex = "(^([A-Z][a-z].*)$)",
           Markup = "<p>&</p>",
           NewContent =
               re:replace(String, Regex, Markup, [multiline, global, {return, list}]),
           NewContent
        end,

    StartParagraph =
        fun(String) ->
           Regex = "(^([ ]*)(It is an ancyent Marinere,)$)",

           Markup = "  <p>\\3<br/>",
           NewContent = re:replace(String, Regex, Markup, [multiline, {return, list}]),
           NewContent
        end,

    Add_br =
        fun(String) ->
           Regex = "(^ {5,7}.*$)",
           Markup = "&<br/>",
           NewContent =
               re:replace(String, Regex, Markup, [multiline, global, {return, list}]),
           NewContent
        end,

    EndParagraph =
        fun(String) ->
           Regex = "(<br/>\\Z)",
           Markup = "\r</p>",
           NewContent =
               re:replace(String, Regex, Markup, [multiline, global, {return, list}]),
           NewContent
        end,

    ReplaceEmtpyLines =
        fun(String) ->
           Regex = "(^$)",
           Markup = "<br/>",
           NewContent =
               re:replace(String,
                          Regex,
                          Markup,
                          [multiline, global, {offset, 490}, {return, list}]),
           NewContent
        end,

    AddEndTags =
        fun(String) ->
           Regex = "(</p>\\Z)",
           Markup = "&\r</body>\r</html>",
           NewContent =
               re:replace(String, Regex, Markup, [multiline, global, {return, list}]),
           NewContent
        end,

    Add_h2Content = Add_h2(FileContent),
    MarkSpecificParagraphContent = MarkSpecificParagraph(Add_h2Content),
    StartParagraphContent = StartParagraph(MarkSpecificParagraphContent),
    Add_br_Content = Add_br(StartParagraphContent),
    EndParagraphContent = EndParagraph(Add_br_Content),
    ReplaceEmtpyLinesContent = ReplaceEmtpyLines(EndParagraphContent),
    AddEndTagsContent = AddEndTags(ReplaceEmtpyLinesContent),
    InsertHeadContent = InsertHead(AddEndTagsContent),

    NewFileName = "new_rime.txt",
    NewFilePath = file_path(NewFileName),
    NewContent = InsertHeadContent,
    Result = file:write_file(NewFilePath, NewContent),

    Result = ok,
    ?_assertEqual(Expected, Result).

% Substitution with sed
insert_title(FileContent) ->
    Expected = 2,
    Regex = "(^.*$)",
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
        re:replace(FileContent, Regex, Markup, [multiline, {return, list}]),
    RegexString = Captured,
    {ok, MP_String} = re:compile(RegexString, [multiline]),
    {match, CapturedStringList} =
        re:run(NewContent, MP_String, [global, {capture, all, list}]),
    Length = length(CapturedStringList),
    Result = Length,
    ?_assertEqual(Expected, Result).

% Handling Roman Numerals with sed
add_h2(FileContent) ->
    Expected = 8,
    Regex = "(^(ARGUMENT\\.|I{0,3}V?I{0,2}\\.)$)",
    Markup = "<h2>&</h2>",
    NewContent =
        re:replace(FileContent, Regex, Markup, [multiline, global, {return, list}]),
    RegexMarkup = "<(h2)>.*?</\\1>",

    {ok, MP} = re:compile(RegexMarkup),
    {match, Captured} = re:run(NewContent, MP, [global, {capture, first, list}]),

    Length = length(Captured),
    Result = Length,
    ?_assertEqual(Expected, Result).

% Handling a Specific Paragraph with sed
mark_specific_paragraph(FileContent) ->
    Expected = 1,
    Regex = "(^([A-Z][a-z].*)$)",
    Markup = "<p>&</p>",
    NewContent =
        re:replace(FileContent, Regex, Markup, [multiline, global, {return, list}]),

    RegexMarkup = "<(p)>.*?</\\1>",
    {ok, MP} = re:compile(RegexMarkup),
    {match, Captured} = re:run(NewContent, MP, [global, {capture, first, list}]),
    %?debugFmt("~p~n",[Captured]),
    Length = length(Captured),
    Result = Length,
    ?_assertEqual(Expected, Result).

% Handling the Lines of the Poem with sed
% after prepending a few spaces, it inserts a p start-tag
start_paragraph(FileContent) ->
    Expected = 1,
    Regex = "(^([ ]*)(It is an ancyent Marinere,)$)",

    Markup = "  <p>\\3",
    NewContent =
        re:replace(FileContent, Regex, Markup, [multiline, {return, list}]),
    RegexMarkup = "<p>",
    {ok, MP} = re:compile(RegexMarkup),
    {match, Captured} = re:run(NewContent, MP, [global, {capture, first, list}]),
    %?debugFmt("~p~n",[Captured]),
    Length = length(Captured),
    Result = Length,
    ?_assertEqual(Expected, Result).

% Handling the Lines of the Poem with sed
% every line that begins with between 5 to 7 spaces gets a br appended to it.
add_br(FileContent) ->
    Expected = 660,
    Regex = "(^ {5,7}.*$)",
    Markup = "&<br/>",
    NewContent =
        re:replace(FileContent, Regex, Markup, [multiline, global, {return, list}]),
    RegexMarkup = "<br/>",
    {ok, MP} = re:compile(RegexMarkup),
    {match, Captured} = re:run(NewContent, MP, [global, {capture, first, list}]),
    Length = length(Captured),
    Result = Length,
    ?_assertEqual(Expected, Result).

% Handling the Lines of the Poem with sed
% the last line of the poem, instead of a br, the s appends a p end-tag
end_paragraph(FileContent) ->
    Expected = 1,
    Regex = "(^([ ]*)(He rose the morrow morn.)$)",
    Markup = "&</p>",
    NewContent =
        re:replace(FileContent, Regex, Markup, [multiline, global, {return, list}]),
    RegexMarkup = "</p>",
    {ok, MP} = re:compile(RegexMarkup),
    {match, Captured} = re:run(NewContent, MP, [global, {capture, first, list}]),
    Length = length(Captured),
    Result = Length,
    ?_assertEqual(Expected, Result).

% Handling the Lines of the Poem with sed
% Replace the blank lines with a br, to keep the verses separated.
replace_emtpy_lines(FileContent) ->
    Expected = 161,
    Regex = "(^$)",
    Markup = "<br/>",
    NewContent =
        re:replace(FileContent, Regex, Markup, [multiline, global, {return, list}]),
    RegexMarkup = "<br/>",
    {ok, MP} = re:compile(RegexMarkup),
    {match, Captured} = re:run(NewContent, MP, [global, {capture, first, list}]),
    Length = length(Captured),
    Result = Length,
    ?_assertEqual(Expected, Result).

% Handling the Lines of the Poem with sed
% append some tags to the end of the poem
add_end_tags(FileContent) ->
    Expected = 1,
    Regex = "(^([ ]*)(He rose the morrow morn.)$)",
    Markup = "&</body></html>",
    NewContent =
        re:replace(FileContent,
                   Regex,
                   Markup,
                   [multiline, global, dollar_endonly, {return, list}]),
    RegexMarkup = "</body></html>",
    {ok, MP} = re:compile(RegexMarkup),
    {match, Captured} = re:run(NewContent, MP, [global, {capture, first, list}]),
    Length = length(Captured),
    Result = Length,
    ?_assertEqual(Expected, Result).

-endif.
-endif.
