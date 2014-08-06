-module(ml_scan_test).

-include_lib("eunit/include/eunit.hrl").

function_definition_test() ->
    {ok, Tokens, _} = ml_scan:string("let two() = 2;"),
    ?assertEqual(Tokens, [{let_t,1,"let"},
                          {chr,1,"two"},
                          {lparen,1,"("},
                          {rparen,1,")"},
                          {equals,1,"="},
                          {number,1,2},
                          {semicolon,1,";"}]).

function_definition_2_test() ->
    {ok, Tokens, _} = ml_scan:string("let double x = x * 2;"),
    ?assertEqual(Tokens, [{let_t,1,"let"},
                          {chr,1,"double"},
                          {chr,1,"x"},
                          {equals,1,"="},
                          {chr,1,"x"},
                          {multi,1,"*"},
                          {number,1,2},
                          {semicolon,1,";"}]).


let_definition_test() ->
    {ok, Tokens, _} = ml_scan:string("let x = 1;"),
    ?assertEqual(Tokens, [{let_t, 1, "let"},
                              {chr,1,"x"},
                              {equals,1,"="},
                              {number,1,1},
                              {semicolon,1,";"}]).

string_test() ->
    {ok, Tokens, _} = ml_scan:string("'stringy'"),
    ?assertEqual(Tokens, [{quote,1,"'"},
                          {chr,1,"stringy"},
                          {quote,1,"'"}]).

unit_test() ->
    {ok, Tokens, _} = ml_scan:string("()"),
    ?assertEqual(Tokens, [{lparen,1,"("},
                          {rparen,1,")"}]).

statement_test() ->
    {ok, Tokens, _} = ml_scan:string("1 + 2;"),
    ?assertEqual(Tokens, [{number,1,1},
                          {plus,1,"+"},
                          {number,1,2},
                          {semicolon,1,";"}]).

statement_multi_test() ->
    {ok, Tokens, _} = ml_scan:string("1      * 2 * 3 *4;"),
    ?assertEqual(Tokens, [{number,1,1},
                          {multi,1, "*"},
                          {number,1,2},
                          {multi,1, "*"},
                          {number,1,3},
                          {multi,1, "*"},
                          {number,1,4},
                          {semicolon,1,";"}]).
