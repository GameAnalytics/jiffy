-module(util).
-export([test_good/1, test_errors/1]).

test_good(Cases) ->
    lists:foreach(fun(Case) -> check_good(Case) end, Cases).

test_errors(Cases) ->
    lists:foreach(fun(Case) -> check_error(Case) end, Cases).

ok_dec(J, _E) ->
    lists:flatten(io_lib:format("Decoded ~p.", [J])).

ok_enc(E, _J) ->
    lists:flatten(io_lib:format("Encoded ~p", [E])).

error_mesg(J) ->
    lists:flatten(io_lib:format("Decoding ~p returns an error.", [J])).

check_good({J, E}) ->
    etap:is(jiffy:decode(J), {ok, E}, ok_dec(J, E)),
    etap:is(jiffy:encode(E), {ok, J}, ok_enc(E, J));
check_good({J, E, J2}) ->
    etap:is(jiffy:decode(J), {ok, E}, ok_dec(J, E)),
    etap:is(jiffy:encode(E), {ok, J2}, ok_enc(E, J2)).

check_error(J) ->
    etap:fun_is(
        fun({error, _}) -> true; (_) -> false end,
        jiffy:decode(J),
        error_mesg(J)
    ).
