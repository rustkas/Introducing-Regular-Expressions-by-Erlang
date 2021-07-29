-module(matching_email_address_tests).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

email_addresses() ->
    ["permissions@oreilly.com",
     "bookquestions@oreilly.com",
     "corporate@oreilly.com",
     " index@oreilly.com"].

email_addresses_test_() ->
    {foreach, local, fun email_addresses/0, [fun matching/1]}.

matching(EmailAddresses) ->
    Expected = true,

    Regex = "^([\\w-!#$%&'*+-/=?^_`{\}~]+)@((?:\\w+\.)+)(?:[a-zA-Z]{2,4})$",
    TunedRegex = re_tuner:replace(Regex),
    {ok, MP} = re:compile(TunedRegex),

    Result =
        lists:all(fun(Elem) ->
                     {match, Elem} = re:run(Elem, MP, [{capture, first, list}]),
                     true
                  end,
                  EmailAddresses),
    ?_assertEqual(Expected, Result).

-endif.
