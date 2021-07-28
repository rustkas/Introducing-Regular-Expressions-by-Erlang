-module(rime_html_builder).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(_) ->
    FileContent = read_rime(),

    Add_h2Content = add_h2(FileContent),
    MarkSpecificParagraphContent = mark_specific_paragraph(Add_h2Content),
    StartParagraphContent = start_paragraph(MarkSpecificParagraphContent),
    Add_br_Content = add_br(StartParagraphContent),
    EndParagraphContent = end_paragraph(Add_br_Content),
    ReplaceEmtpyLinesContent = replace_emtpy_lines(EndParagraphContent),
    AddEndTagsContent = add_end_tags(ReplaceEmtpyLinesContent),
    InsertHeadContent = insert_head(AddEndTagsContent),

    NewFileName = "new_rime.html",
    NewFilePath = file_path(NewFileName),
    NewContent = InsertHeadContent,
    file:write_file(NewFilePath, NewContent),

    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% File
%%====================================================================

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

%%====================================================================
%% Converter
%%====================================================================

-spec insert_head(String) -> NewString
    when String :: string(),
         NewString :: string().
insert_head(String) ->
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
    NewContent.

-spec add_h2(String) -> NewString
    when String :: string(),
         NewString :: string().
add_h2(String) ->
    Regex = "(^(ARGUMENT\\.|I{0,3}V?I{0,2}\\.)$)",
    Markup = "<h2>&</h2>",
    NewContent =
        re:replace(String, Regex, Markup, [multiline, global, {return, list}]),
    NewContent.

-spec mark_specific_paragraph(String) -> NewString
    when String :: string(),
         NewString :: string().
mark_specific_paragraph(String) ->
    Regex = "(^([A-Z][a-z].*)$)",
    Markup = "<p>&</p>",
    NewContent =
        re:replace(String, Regex, Markup, [multiline, global, {return, list}]),
    NewContent.

-spec start_paragraph(String) -> NewString
    when String :: string(),
         NewString :: string().
start_paragraph(String) ->
    Regex = "(^([ ]*)(It is an ancyent Marinere,)$)",

    Markup = "  <p>\\3<br/>",
    NewContent = re:replace(String, Regex, Markup, [multiline, {return, list}]),
    NewContent.

-spec add_br(String) -> NewString
    when String :: string(),
         NewString :: string().
add_br(String) ->
    Regex = "(^ {5,7}.*$)",
    Markup = "&<br/>",
    NewContent =
        re:replace(String, Regex, Markup, [multiline, global, {return, list}]),
    NewContent.

-spec end_paragraph(String) -> NewString
    when String :: string(),
         NewString :: string().
end_paragraph(String) ->
    Regex = "(<br/>\\Z)",
    Markup = "\r</p>",
    NewContent =
        re:replace(String, Regex, Markup, [multiline, global, {return, list}]),
    NewContent.

-spec replace_emtpy_lines(String) -> NewString
    when String :: string(),
         NewString :: string().
replace_emtpy_lines(String) ->
    Regex = "(^$)",
    Markup = "<br/>",
    NewContent =
        re:replace(String,
                   Regex,
                   Markup,
                   [multiline, global, {offset, 490}, {return, list}]),
    NewContent.

-spec add_end_tags(String) -> NewString
    when String :: string(),
         NewString :: string().
add_end_tags(String) ->
    Regex = "(</p>\\Z)",
    Markup = "&\r</body>\r</html>",
    NewContent =
        re:replace(String, Regex, Markup, [multiline, global, {return, list}]),
    NewContent.
