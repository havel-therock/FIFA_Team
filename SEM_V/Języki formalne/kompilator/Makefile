
run: program
	./kompilator input.txt

program: kompilator.y kompilator.l
	bison -d kompilator.y 
	lex kompilator.l 
	g++ -o kompilator lex.yy.c kompilator.tab.c -ll -lm

clean:
	rm kompilator.tab.c kompilator.tab.h lex.yy.c $(OBJ) kompilator
