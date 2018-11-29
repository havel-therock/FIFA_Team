/*
* author: niebieski-kaptutek & twórcy dokumentacji
*/

%{
#include "bison.tab.h"
#include <stdlib.h>
void yyerror(char *);
%}

/* zmienna globalna yylval służy do przekazywania parserowi atrybutu tokenu 
   (wartości semantycznej); przekazywana jest w memncie przekazania tokenu(NUM) do parsera */
%%
^\#.*\n  ;
\\\n ;
[0-9]+ 		{ yylval = atoi(yytext); return NUM;}	/*Cyfry*/

[-+()=/*\n\^%]     { return *yytext; printf("%s", yytext); } /*Operatory*/
[ \t]+
#.*\n 	{ ; } 
\\\n	{ ; } 
([^-+()=/*\n\^%]|\D)+ { printf("Zły znak: '%c'\n", yytext[0]); }
%%

int yywrap(void) {
    return 1;
}
