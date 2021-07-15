-module(tests_04_control_character_tests).

%-define(RESEARCH, true).
%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

-ifdef(RESEARCH).

search_non_word_boundary_01_test() ->
    Expected = ok,
    ValidCharacterList = lists:seq(0, 255),
    RegularExpression = element(1, hd(control_x_tuples())),
    {ok, MP} = re:compile(RegularExpression),
    Result =
        lists:foreach(fun(Elem) ->
                         case re:run([Elem], MP) of
                             {match, _} ->
                                 ?debugFmt("Found! = ~p, ~p~n", [Elem, [Elem]]);
                             nomatch ->
                                 false
                         end
                      end,
                      %{match, _} = re:run([Elem], MP)
                      ValidCharacterList),
    ?assertEqual(Expected, Result).

control_x_tuples() ->
    %{RegularExpression,Value}
    Numbers =
        [{"\\c0", 112},
         {"\\c1", 113},
         {"\\c2", 114},
         {"\\c3", 115},
         {"\\c4", 116},
         {"\\c5", 117},
         {"\\c6", 118},
         {"\\c7", 119},
         {"\\c8", 120},
         {"\\c9", 121}],

    Numbers.

-else.

% Nothing

-endif.
-endif.
