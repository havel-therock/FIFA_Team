#author: niebieski-kapturek & Bill Gates

program: bison.y flex.l
	bison -d bison.y 
	lex flex.l 
	gcc -o kalkulator lex.yy.c bison.tab.c -ll -lm

clean:
	rm bison.tab.c bison.tab.h lex.yy.c $(OBJ) kalkulator
