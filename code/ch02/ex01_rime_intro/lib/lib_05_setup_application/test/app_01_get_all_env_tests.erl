% For research For research mode, activate the RESEARCH constant.

-module(app_01_get_all_env_tests).

-define(RESEARCH, true).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

-ifdef(RESEARCH).

letters_research_test() ->
    
    Result = application:get_all_env(),

    ?debugFmt("Started = ~p~n", [Result]).

-else.

ensure_started_01_test() ->
    Expected = true,
    % inner libs of current rebar3 project
    AppNames =
        ["kernel",
         "stdlib",
         "eunit_helper"
         "ex01_rime_intro",
         "lib_01_rime_intro",
         "lib_02_simple_pattern_matching",
         "lib_03_posix_notation",
         "lib_04_maching_any_character",
         "lib_05_setup_application"],
    Result =
        lists:all(fun(AppName) ->
                     Result = application:ensure_started(AppName),
                     {error, {bad_application, AppName}} == Result
                  end,
                  AppNames),

    ?assertEqual(Expected, Result).

-endif.
-endif.
