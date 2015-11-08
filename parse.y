%{
#include <stdio.h>
#include <stdlib.h>
#include "mlang.h"

int yylex(void);
int yyerror(char const *str);
%}

%union {
    long integer;
    double real;
}

%token  '+' '-' '*' '/'
%token  '\n'
%token  <integer>   tINTEGER_LITERAL
%token  <real>      tDOUBLE_LITERAL
%type   <real>      exp primary

%left   '+' '-'
%left   '*' '/'
%%

program     : stmts
;
stmts       : stmt
            | stmts stmt
;
stmt        : exp '\n'
            {
                printf("%lf\n", $1);
            }
;
exp         : primary
            {
                $$ = $1;
            }
            | exp '+' exp
            {
                $$ = $1 + $3;
            }
            | exp '-' exp
            {
                $$ = $1 - $3;
            }
            | exp '*' exp
            {
                $$ = $1 * $3;
            }
            | exp '/' exp
            {
                $$ = $1 / $3;
            }
;
primary     : tDOUBLE_LITERAL
;
%%
int yyerror (char const *str)
{
    extern char *yytext;
    fprintf(stderr, "parser error near %s. (%s)\n", yytext, str);
    return 0;
}

int main(void)
{
    extern int yydebug;
    extern int yyparse(void);
    extern FILE *yyin;

    /*yydebug = 1;*/
    yyin = stdin;
    if(yyparse()) {
        fprintf(stderr, "Error ! Error ! Error !\n");
        exit(1);
    }

    return 0;
}
