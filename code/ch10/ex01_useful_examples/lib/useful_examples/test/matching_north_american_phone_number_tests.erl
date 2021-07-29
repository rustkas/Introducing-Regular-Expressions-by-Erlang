-module(matching_north_american_phone_number_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

north_american_phone_numbers() ->
    ["(707)-827-7019",
     "(707-827-7019",
     "707)-827-7019",
     "707-827-7019",
     "707827-7019",
     "7078277019"].

north_american_phone_number_test_() ->
    {foreach,
     local,
     fun north_american_phone_numbers/0,
     [fun matching_with_comments/1, fun matching/1]}.

matching_with_comments(NorthAmericanPhoneNumbers) ->
    Expected = true,

    Regex =
        "
^          # is the zero-width assertion for the beginning of a line or subject.
\\(?       # is a literal left parenthesis, but it is optional (?).
(?:\\d{3}) # is a non-capturing group matching three consecutive digits.
\\)?       # is an optional right parenthesis.
[-.]?      # allows for an optional hyphen or period (dot).
(?:\\d{3}) # is another non-capturing group matching three more consecutive digits.
[-.]?      # allows for an optional hyphen or dot again.
(?:\\d{4}) # is yet another non-capturing group matching exactly four consecutive digits.
$          # matches the end of a line or subject.
",
    {ok, MP} = re:compile(Regex, [extended]),

    Result =
        lists:all(fun(Elem) ->
                     RunResult = re:run(Elem, MP, [{capture, first, list}]),
                     {Result, [Elem]} = RunResult,
                     Result == match
                  end,
                  NorthAmericanPhoneNumbers),
    ?_assertEqual(Expected, Result).

matching(NorthAmericanPhoneNumbers) ->
    Expected = true,

    Regex = "^\\(?(?:\\d{3})\\)?[-.]?(?:\\d{3})[-.]?(?:\\d{4})$",
    {ok, MP} = re:compile(Regex, [extended]),

    Result =
        lists:all(fun(Elem) ->
                     RunResult = re:run(Elem, MP, [{capture, first, list}]),
                     {Result, [Elem]} = RunResult,
                     Result == match
                  end,
                  NorthAmericanPhoneNumbers),
    ?_assertEqual(Expected, Result).

-endif.
