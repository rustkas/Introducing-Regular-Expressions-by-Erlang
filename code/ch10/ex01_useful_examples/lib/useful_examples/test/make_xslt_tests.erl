% For research For research mode, activate the RESEARCH constant.
%
-module(make_xslt_tests).

-export([read_lorem/0]).

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

read_lorem() ->
    String = read_local_file("lorem.dita"),
    String.

lorem_test_() ->
    {foreach, local, fun read_lorem/0, [fun make_xslt_01/1]}.

% Convert lorem.dita tags into a simple XSLT stylesheet lorem.xslt
make_xslt_01(FileContent) ->
    Expected = ok,
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

    Markup =
        "<xsl:template match=\"&\">
        <xsl:apply-templates/>
    </xsl:template>\n\r",

    XSLT_ItemList =
        lists:map(fun(Elem) -> re:replace(Elem, Elem, Markup, [{return, list}]) end,
                  SortedList),

    XSLT_ItemListString =
        lists:foldl(fun(Item, Acc) -> Acc ++ Item end, "", XSLT_ItemList),

    TopText =
        "<xml:stylsheet version=\"2.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">\n\r",
    EndText = "</xsl:stylesheet>",
    XSLT_StylesheetContent = TopText ++ XSLT_ItemListString ++ EndText,

    NewFileName = "lorem.xslt",
    NewFilePath = file_path(NewFileName),
    NewContent = XSLT_StylesheetContent,
    Result = file:write_file(NewFilePath, NewContent),

    ?_assertEqual(Expected, Result).

-endif.
