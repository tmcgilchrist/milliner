-module(ml_parse_test).

-include_lib("eunit/include/eunit.hrl").

function_definition_test() ->
    {ok, Tokens, _} = ml_scan:string("let two() = 2;"),
    {ok, AST} = ml_parse:parse(Tokens),
    ?assertEqual(AST,
                 {{let_t,1,"let"},
                  {chr,1,"two"},
                  {unit},
                  {equals,1,"="},
                  {number,1,2}}).

function_definition_string_test() ->
    {ok, Tokens, _} = ml_scan:string("let two() = 'string';"),
    {ok, AST} = ml_parse:parse(Tokens),
    ?assertEqual(AST,
                 {{let_t,1,"let"},
                  {chr,1,"two"},
                  {unit},
                  {equals,1,"="},
                  {string, "string"}}).

function_definition_args_test() ->
    {ok, Tokens, _} = ml_scan:string("let two x = x;"),
    {ok, AST} = ml_parse:parse(Tokens),
    ?assertEqual(AST,{{let_t,1,"let"},
                      {chr,1,"two"},
                      {arguments,{chr,1,"x"}},
                      {equals,1,"="},
                      {chr,1,"x"}}).


function_definition_statement_test() ->
    {ok, Tokens, _} = ml_scan:string("let two x = x + 2;"),
    {ok, AST} = ml_parse:parse(Tokens),
    ?assertEqual(AST, {{let_t,1,"let"},
                       {chr,1,"two"},
                       {arguments,{chr,1,"x"}},
                       {equals,1,"="},
                       {stmt, {chr,1,"x"},{multi},{number,1,2}}}).

statement_number_test() ->
    {ok, Tokens, _} = ml_scan:string("x + 2;"),
    {ok, AST} = ml_parse:parse(Tokens),
    ?assertEqual(AST, {stmt, {chr,1,"x"},{multi},{number,1,2}}).

statement_fun_call_test() ->
    {ok, Tokens, _} = ml_scan:string("two();"),
    {ok, AST} = ml_parse:parse(Tokens),
    ?assertEqual(AST, {stmt, {fun_call, "two"}}).

statement_fun_call_args_test() ->
    {ok, Tokens, _} = ml_scan:string("two(1);"),
    {ok, AST} = ml_parse:parse(Tokens),
    io:format("AST: ~p~n", [AST]),
    ?assertEqual(AST, {stmt,{fun_call, "two",{number,1,1}}}).
