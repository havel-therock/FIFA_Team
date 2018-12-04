%{
#include "bison.tab.h"
#include <stdlib.h>
void yyerror(char *);
%}

%%
^\#.*\n			;/*komentarz w jednej lini*/
\\\n			;/*przejscie do nowej lini*/
[0-9]+			{yylval = atoi(yytext); return NUM;} /*cyfry*/
[-+()=/*\n\^%]		{return *yytext; printf("%s", yytext);} /*operatory*/
([^-+()=/*\n\^%\\])+ 	{printf("Zły znak: '%c'\n", yytext[0]);}

%%

int yywrap(void){
	return 1;
}
