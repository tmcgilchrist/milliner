Nonterminals
  expressions
  statement
  unit
  args
  string
  let_expr.

Terminals
  number chr
  let_t
  lparen rparen
  equals
  quote
  plus multi
  semicolon.

Rootsymbol
  expressions.

expressions -> let_expr: '$1'.

let_expr -> let_t chr args equals statement semicolon : {'$1', '$2', '$3', '$4', '$5'}.

statement -> number: '$1'.
statement -> string: '$1'.
statement -> chr:    '$1'.

args -> unit: '$1'.
args -> chr : {arguments, '$1'}.

unit -> lparen rparen: {unit}.
string -> quote chr quote: {string, value_of('$2')}.


Erlang code.

value_of(Token) ->
    element(3, Token).
