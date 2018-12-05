%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
extern FILE *yyin;
void yyerror(const char *);
void addc(char);
void addi(int);
void display();
int yylex(void);
int err = 0;
char tabc[20];
int tabi[20];
int help[20];   /*0-liczba, 1-znak*/
int h = 0, i=0, c=0;
%}
%token NUM
%left '+' '-'
%left '*' '/' '%'
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
				display();
				printf("\n=%d\n", $1);
			}else{
				err = 0;
			}
		}

;

exp:
NUM			{if(err==0){addi($1);}}
| '-' exp %prec NEG	{$$ = -$2;// addi(-$2);
                                addi(-$2); addc('~');}
| exp '+' exp		{$$ = $1 + $3; addc('+');}
| exp '-' exp		{$$ = $1 - $3; addc('-');}
| exp '*' exp		{$$ = $1 * $3; addc('*');}
| exp '/' exp		{
				if($3!=0){
					if($1%$3==0){
						$$ = $1 / $3;
						addc('/');
					}else{
                        if($1*$2<0){
						    $$ = ($1 / $3) - 1;
						    addc('/');
                        }else{
                            $$ = ($1 / $3);
						    addc('/');
                        }
					}
				}else{
					yyerror("Z");
					err = 1;
				}
			}
| exp '^' exp		{$$ = pow($1,$3); addc('^');}
| exp '%' exp		{
				if($3>0 && $1>=0){
					$$ = $1 % $3;
					addc('%');
				}else if($1<0){
					$$ = $3 - ((-$1) % $3);
					addc('%');
				}else{
					yyerror("Z");
					err = 1;
				}
			}

| '-' '(' exp ')'   { $$ = -$3; addc('~');}
| '(' exp ')'		{ $$ = $2;}

;

%%
void display(){
    int chi = 0, chc = 0;
	for(int j=0;j<h;j++){
		if(help[j]==0){
			if(j+1<sizeof(help)/sizeof(help[0])){
				if(help[j+1]==0){ 
					if(!(tabi[chi]+tabi[chi+1]==0 && tabi[chi+1]<0)){ //tabi ma za nadprogramowe wartosci np. 20 -20\
                                                                        gdy taka sytuacja nie zachodzi drukujemy\
                                                                        a gdy zajdzie to mamy else nizej\

						printf("%d ",tabi[chi]);
                        chi++;
					}else{
                        tabi[chi+1] = tabi[chi+1] * (-1); //razy minus jeden niweluje błąd z podwójnym minusem - i ~
                        chi++;
                    }
				}else{
					printf("%d ",tabi[chi]);
                    chi++;
				}
			}else{
				printf("%d ",tabi[chi]);
                chi++;
			}
		}else if(help[j]==1){
			printf("%c ",tabc[chc]);
            chc++;
		}
	}
	h=0;
    i=0;
    c=0;
}
void addc(char ch){
	tabc[c]=ch;
    c++;
	help[h]=1;
	h++;  
}

void addi(int vaule){
	tabi[i]=vaule;
    i++;
	help[h]=0;
	h++;
}

void yyerror (char const *s){
	if(*s=='Z'){
		fprintf (stderr, "Nie dziel przez ZERO!\n");
        h=0;
        i=0;
        c=0;
	}else{
  		fprintf (stderr, "Błąd\n");
		err = 1;
        h=0;
        i=0;
        c=0;
		yyparse();
	}
}

int main(int argc, char const *argv[]) {
    if(argc==2){
        if(argv[1]!="/dev/stdin")
            yyin = fopen(argv[1], "r");
    }
    yyparse();
    return 0;
}