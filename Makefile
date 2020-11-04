all: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c:  CS315f20_team32.y lex.yy.c
	yacc  CS315f20_team32.y
lex.yy.c:  CS315f20_team32.l
	lex  CS315f20_team32.l