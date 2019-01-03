/**
Jan Sieradzki
236441
*/

%{
#include "kompilator.tab.h"
#include <stdlib.h>


%}

%x quote

%%

(\[)			{BEGIN(quote);}
<quote>(\[)             { printf("Błąd : zagnieżdżenie komentarza.\n"); yyterminate(); }
<quote>(])		{BEGIN(INITIAL);}	
<quote>(\n|.) 
<quote><<EOF>> 		{ printf("Błąd : brak zamnknięcia komentarza.\n"); yyterminate(); }  				

(DECLARE) 		{return DECLARE; }
(IN) 			{return IN; }
(END) 			{return END; }

(IF)			{return IF; }
(THEN) 			{return THEN; }
(ENDIF) 		{return ENDIF; }
(ELSE)			{return ELSE; }

(WHILE) 		{return WHILE; }
(DO) 			{return DO; }
(ENDWHILE) 		{return ENDWHILE; }
(ENDDO) 		{return ENDDO; }

(FOR) 			{return FOR; }
(ENDFOR) 		{return ENDFOR; }
(FROM) 			{return FROM; }
(TO) 			{return TO; }
(DOWNTO) 		{return DOWNTO; }

(READ) 			{return READ; }
(WRITE) 		{return WRITE; }

(:=) 			{return ASSIGN; }
(<=)     		{ return LWE; }
(>=)     		{ return GRE; }
(<)     		{ return LW; }
(>)     		{ return GR; }
(!=)     		{ return NE; }
(=)     		{ return EQ; }

[-+()/*%:;]     	{ return *yytext; printf("%s", yytext); }

[_a-z]+			{ yylval.str = (char *)strdup(yytext); return PIDENTIFIER;}	
([1-9][0-9]*)|[0] 	{ yylval.str = (char *)strdup(yytext); return NUM;}
[\t\r\n]+;


%%

int yywrap(void) {
	/*FILE *myfile = fopen("input.txt", "r");

	if (!myfile) {
		printf( "I can't open InputFileHTML.html");
		return -1;
	}
	
	yyin = myfile;
	do
    	{
        	yyparse();
    	}while (!feof(yyin));*/
	/*printf( "I can't open InputFileHTML.html");
    FILE *myfile = fopen("input.txt", "r");

	if (!myfile) {
		printf( "I can't open InputFileHTML.html");
		return -1;
	}
	
	yyin = myfile;*/

   /* FILE *myfile2 = fopen("output.txt", "wb");
	
	if (!myfile2) {
		printf( "I can't open OutputFile.html" );
		return -1;
	}
	
	yyout = myfile2;*/
  return 0;
}

