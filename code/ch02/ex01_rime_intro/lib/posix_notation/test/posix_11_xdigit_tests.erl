% For research mode, activate the RESEARCH constant.
% Hexadecimal digits
-module(posix_11_xdigit_tests).

%-define(RESEARCH, true).
-define(REGEX, "[[:xdigit:]]").

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

-ifdef(RESEARCH).

research_test() ->
    Expected = ok,
    ValidCharacterList = lists:seq(0, 255),
    Hexadecimal =
        lists:map(fun(Elem) -> io_lib:format("~.16X", [Elem, "0x"]) end,
                  ValidCharacterList),
    %?debugFmt("Found! = ~p~n", [Hexadecimal]).
    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:foreach(fun(Elem) ->
                         case re:run([Elem], MP) of
                             {match, _} ->
                                 ?debugFmt("Found! = ~p~n", [Elem]);
                             nomatch ->
                                 false
                         end
                      end,
                      Hexadecimal),
    ?assertEqual(Expected, Result).

-else.

research_01_test() ->
    Expected = true,
    ValidCharacterList = lists:seq(0, 255),
    Hexadecimal =
        lists:map(fun(Elem) -> io_lib:format("~.16X", [Elem, "0x"]) end,
                  ValidCharacterList),

    RegularExpression = ?REGEX,
    {ok, MP} = re:compile(RegularExpression),
    {match, _} = re:run(Hexadecimal, MP),
    Result = true,
    ?assertEqual(Expected, Result).

-endif.
-endif.
