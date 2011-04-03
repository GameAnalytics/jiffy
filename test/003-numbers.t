#! /usr/bin/env escript

main([]) ->
    code:add_pathz("ebin"),
    code:add_pathz("test"),
    
    etap:plan(47),
    util:test_good(good()),
    util:test_errors(errors()),
    etap:end_tests().

good() ->
    [
        {<<"0">>, 0},
        {<<"-0">>, 0, <<"0">>},
        {<<"1">>, 1},
        {<<"12">>, 12},
        {<<"-3">>, -3},
        {<<"309230948234098">>, 309230948234098},
        {<<"1.0">>, 1.0, <<"1">>},
        {<<"0.3">>, 0.3},
        {<<"2.4234324">>, 2.4234324, <<"2.42343">>},
        {<<"-3.1416">>, -3.1416},
        {<<"1E4">>, 10000.0, <<"10000">>},
        {<<"1.0E+01">>, 10.0, <<"10">>},
        {<<"1e1">>, 10.0, <<"10">>},
        {<<"3.0E2">>, 300.0, <<"300">>},
        {<<"0E3">>, 0.0, <<"0">>},
        {<<"1.5E3">>, 1500.0, <<"1500">>},
        {<<"1.5E-1">>, 0.15, <<"0.15">>},
        {<<"-0.323E+2">>, -32.3, <<"-32.3">>}
    ].

errors() ->
    [
        <<"02">>,
        <<"-01">>,
        <<"+12">>,
        <<"-">>,
        <<"1.">>,
        <<".1">>,
        <<"1.-1">>,
        <<"1E">>,
        <<"1-E2">>,
        <<"2E +3">>,
        <<"1EA">>
    ].
