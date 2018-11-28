/*
*
* author: niebieski-kapturek, twórcy dokumentacji
* version: 1.0 - uboga dla kolegów xD 
*
*/

%{
    #include <stdio.h>
    #include<math.h>
    void yyerror(const char *);
    int yylex(void);
    int err = 0;
%}
%token NUM
/* Ustalenie wiązań dla operatorów i nadanie im priorytetów. Kolejność lini odpowiada wzrostowi priorytetu */
%left '+' '-'
%left '*' '/' '%'
%right '^'
%right UMINUS
%%
/* Tworzenie struktury reguł gramatycznych */
input   : /* empty */
        |  input '\n'
        |  input  exp '\n' { printf("\nWynik: %d\n",$2); }
        ;

exp:	NUM		{printf("%d ", $1);}
| exp '+' exp   {$$ = $1 + $3; printf("+ ");}
| exp '-' exp   {$$ = $1 - $3; printf("- ");}
| exp '*' exp   {$$ = $1 * $3; printf("* ");}
| exp '/' exp	{ 
	if($3>0){
		$$ = $1 / $3;
		printf("/ ");
	}
	else{
		yyerror("D");
		err=1;		
	}
}
| exp '%' exp { 
	if($3>0){
		$$ = $1 % $3;
		printf("%% ");
	}
	else{
		yyerror("E");
		err=1;		
	}
}
| exp '^' exp			{ $$ = pow($1,$3); printf("^ ");}
|'-' exp %prec UMINUS	{ $$ = -$2;printf("-%d ",$2);}
| '(' exp ')'			{ $$ = $2;}
;

%%


void yyerror (char const *s){
	if (*s=='D')
		fprintf (stderr, "Błąd dzielenie przez zero!\n");
	if (*s=='E')
		fprintf (stderr, "Błąd dzielenie przez zero!\n");
	else
  		fprintf (stderr, "Błąd :(\n");
}
int main(void) {
    yyparse();
}
