-module(ml_parse_test).

-include_lib("eunit/include/eunit.hrl").

function_definition_test() ->
    {ok, Tokens, _} = ml_scan:string("let two() = 2;"),
    {ok, AST} = ml_parse:parse(Tokens),
    ?assertEqual(AST,
                 {{let_t,1,"let"},
                  {space,1," "},
                  {chr,1,"two"},
                  {unit},
                  {number,1,2}}).

function_definition_args_test() ->
    {ok, Tokens, _} = ml_scan:string("let two() = 'string';"),
    io:format("Tokens: ~p~n", [Tokens]),
    {ok, AST} = ml_parse:parse(Tokens),
    ?assertEqual(AST,
                 {{let_t,1,"let"},
                  {space,1," "},
                  {chr,1,"two"},
                  {unit},
                  {string, "string"}}).
