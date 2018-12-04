%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror(const char *);
void add(char,int);
void show();
int yylex(void);
int err = 0;
char tab[20];
int help[20];/*0-liczba, 1-znak*/
int l = 0;
%}
%token NUM
%left '+' '-'
%left '*' '/'
%left '%'
%right '^'
%precedence NEG /*unary '-'*/
%%
input:
  %empty
| input line
;

line:
  '\n'
| exp '\n' 	{
			if(err==0){
				show();
				printf("\n=%d\n", $1);
			}else{
				err = 0;
			}
		}
;

exp:
NUM			{if(err==0){add((char)$1,0);}}//printf("%d ",$1);}}
| '-' exp %prec NEG	{$$ = -$2; add((char)(-$2),0);}//printf("-%d ",$2);}
| exp '+' exp		{$$ = $1 + $3; add('+',1);}//printf("+ ");}
| exp '-' exp		{$$ = $1 - $3; add('-',1);}//printf("- ");}
| exp '*' exp		{$$ = $1 * $3; add('*',1);}//printf("* ");}
| exp '/' exp		{
				if($3!=0){
					if($1%$3==0){
						$$ = $1 / $3;
						//printf("/ ");
						add('/',1);
					}else{
						$$ = ($1 / $3) - 1;
						add('/',1);
						//printf("/ ");
					}
				}else{
					yyerror("Z");
					err = 1;
				}
			}
| exp '^' exp		{$$ = pow($1,$3); add('^',1);}//printf("^ ");}
| exp '%' exp		{
				if($3>0 && $1>=0){
					$$ = $1 % $3;
					add('%',1);
					//printf("%% ");
				}else if($1<0){
					$$ = $3 - ((-$1) % $3);
					add('%',1);
					//printf("%% ");
				}else{
					yyerror("Z");
					err = 1;
				}
			}
| '(' exp ')'		{ $$ = $2;}
;
%%
void show(){
	for(int i=0;i<l;i++){
		if(help[i]==0){
			if(i+1<sizeof(help)/sizeof(help[0])){
				if(help[i+1]==0){
					if(!(tab[i]+tab[i+1]==0 && tab[i+1]<0)){
						printf("%d ",tab[i]);
					}
				}else{
					printf("%d ",tab[i]);
				}
			}else{
				printf("%d ",tab[i]);
			}
		}else if(help[i]==1){
			printf("%c",tab[i]);
		}
	}
	l=0;
}
void add(char a,int i){
	tab[l]=a;
	help[l]=i;
	l++;
}
void yyerror (char const *s){
	if(*s=='Z'){
		fprintf (stderr, "Nie dziel przez ZERO!\n");
	}else{
  		fprintf (stderr, "Błąd\n");
		err = 1;
	}
}
int main(void) {
    yyparse();
}
