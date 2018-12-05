%{
#include "bison.tab.h"
#include <stdlib.h>
#include <string.h>
void yyerror(char *);
%}

%%
^\#(.*\\\n)*.*\n			;/*komentarze */
\\\n			;/*przejscie do nowej lini*/
[ \t]+		    ;
[0-9]+			{yylval = atoi(yytext); return NUM;} /*cyfry*/
[-+()=/*\n\^%]		{return *yytext; printf("%s", yytext);} /*operatory*/
([^-+()=/*\n\^%\\ \t])+ 	{printf("Zły znak: '%c'\n", yytext[0]);}

%%

int yywrap(void){
    
	return 1;
}