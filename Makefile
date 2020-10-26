all: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: group32.y lex.yy.c
	yacc group32.y
lex.yy.c: group32.l
	lex group32.l