%{
  #include <cstdio>
  #include <string.h> // para poder usar a string no linux
  #include "code.tab.h"  // para obter os tipos de token do bison
%}
RECEBE "="
%%
[ \t\n]           ;
[0-9]+\.[0-9]+    { yylval.fval = atof(yytext); return FLOAT; }
[0-9]+            { yylval.ival = atoi(yytext); return INT; }
[a-zA-Z0-9]+      { yylval.sval = strdup(yytext); return VAR; }
{RECEBE} {yylval.sval = strdup(yytext); return RECEBE;}
%%
