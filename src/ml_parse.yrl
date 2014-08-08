Nonterminals
  expressions
  statement
  unit
  args
  arg_list
  string
  infix_op
  let_expr.

Terminals
  number chr
  let_t
  lparen rparen
  equals
  quote
  comma
  plus multi
  semicolon.

Rootsymbol
  expressions.

expressions -> let_expr: '$1'.
expressions -> statement: '$1'.

let_expr -> let_t chr args equals statement : {'$1', '$2', '$3', '$4', '$5'}.

statement -> chr unit semicolon: {stmt, {fun_call, value_of('$1')}}.
statement -> chr lparen arg_list rparen semicolon: {stmt, {fun_call, value_of('$1'), '$3'}}.


statement -> number infix_op number semicolon: {stmt, '$1', '$2', '$3'}.
statement -> chr infix_op number semicolon: {stmt, '$1', '$2', '$3'}.
statement -> number infix_op chr semicolon: {stmt, '$1', '$2', '$3'}.
statement -> chr infix_op chr semicolon: {stmt, '$1', '$2', '$3'}.

statement -> number semicolon: '$1'.
statement -> string semicolon: '$1'.
statement -> chr semicolon:    '$1'.

args -> unit: '$1'.
args -> chr : {arguments, '$1'}.

arg_list -> number arg_list: {arg_list, '$1', value_of('$2')}.
arg_list -> chr arg_list:    {arg_list, '$1', value_of('$2')}.
arg_list -> number: '$1'.
arg_list -> chr: '$1'.

unit -> lparen rparen: {unit}.
string -> quote chr quote: {string, value_of('$2')}.
infix_op -> multi: {multi}.
infix_op -> plus: {multi}.



Erlang code.

value_of(Token) ->
    element(3, Token).
