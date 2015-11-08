all: bin/mlang
parse.tab.c: parse.y
	bison -dv parse.y

lex.yy.c: scan.l
	lex scan.l

bin/mlang: parse.tab.c lex.yy.c
	cc -o bin/mlang -DYYERROR_VERBOSE -DYYDEBUG parse.tab.c lex.yy.c

clean:
	rm lex.yy.c parse.output parse.tab.c parse.tab.h bin/mlang
