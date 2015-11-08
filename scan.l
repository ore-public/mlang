%{
#include <stdio.h>
#include "parse.tab.h"

int yywrap(void)
{
    return 1;
}
%}

%%
"+"   return '+';
"-"   return '-';
"*"   return '*';
"/"   return '/';
"\n"  return '\n';

[1-9][0-9]* {
    long temp;
    sscanf(yytext, "%li", &temp);
    yylval.real = temp;
    return tDOUBLE_LITERAL;
}

[0-9]*\.[0-9]* {
    double temp;
    sscanf(yytext, "%lf", &temp);
    yylval.real = temp;
    return tDOUBLE_LITERAL;
}
%%
