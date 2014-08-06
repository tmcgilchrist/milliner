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
