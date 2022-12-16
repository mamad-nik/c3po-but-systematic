flebi: fb.l b.y	
	bison -d b.y
	flex fb.l
	cc -o $@ b.tab.c lex.yy.c -lfl
