Definitions.

D = [0-9]
IDENT = [a-z|_|-]

Rules.

_           :  {token, {underscore, TokenLine, TokenChars}}.
{D}+        :  {token, {number, TokenLine, list_to_integer(TokenChars)}}.
let         :  {token, {let_t, TokenLine, TokenChars}}.
()          :  {token, {unit, TokenLine, TokenChars}}.
{IDENT}+    :  {token, {chr, TokenLine, TokenChars}}.
\=          :  {token, {equals, TokenLine, TokenChars}}.
'           :  {token, {quote, TokenLine, TokenChars}}.
\;          :  {token, {semicolon, TokenLine, TokenChars}}.
\(          :  {token, {lparen, TokenLine, TokenChars}}.
\)          :  {token, {rparen, TokenLine, TokenChars}}.
[\s|\n]+    :  skip_token.
\+          :  {token, {plus, TokenLine, TokenChars}}.
\*          :  {token, {multi, TokenLine, TokenChars}}.

Erlang code.
