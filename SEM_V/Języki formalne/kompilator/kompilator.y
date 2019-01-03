/**
Jan Sieradzki
236441
*/

%{
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdarg.h>
#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>
#include <algorithm>
#define YYDEBUG 1
using namespace std;

typedef struct {
    	string type;
	bool initialized = false;
	long long int start;
	long long int end;
	long long int size;
} structures;

void yyerror(const char *);
int yylex(void);
int err = 0;
extern int yylineno;

map<string, structures> declarationSet;

structures createNum();
structures createArray(long long int start,long long int end);

%}
%define parse.error verbose
%define parse.lac full
%union {
    char* str;
    long long int num;
}
%token <str> NUM DECLARE IN END IF THEN ENDIF ELSE WHILE DO ENDWHILE ENDDO FOR ENDFOR TO DOWNTO PIDENTIFIER ASSIGN FROM READ WRITE '(' ')' GRE LWE EQ NE LW GR ':' ';'
%left '+' '-'
%left '*' '/' '%'
//%precedence NEG
%%

program:
DECLARE declarations IN commands END {
	cout << "HALT";
	  return 0;
}
;
declarations:
declarations PIDENTIFIER ';' {
	if(declarationSet.find($2)==declarationSet.end()) {
		structures structure = createNum();
		declarationSet.insert(make_pair($2, structure));
    }
	else {
		cout << "ERROR near line : " << yylineno << " : That variable is already declared : " << $2 << " ." << endl;
	return 0;   
	}
}
| declarations PIDENTIFIER '(' NUM ':' NUM ')' ';'{
	if(declarationSet.find($2)==declarationSet.end()) {
		if(atoll($6)>atoll($4)){
			structures structure = createArray(atoll($4),atoll($6));
			declarationSet.insert(make_pair($2, structure));
		}
		else{
			cout << "ERROR near line : " << yylineno << " : Wrong bounds of array (proper way -> tab(n:m) where n<m) " << endl;
			return 0;
		}
    }
	else {
		cout << "ERROR near line : " << yylineno << " : That variable is already declared : " << $2 << " ." << endl;
		return 0;
	return 0;   
	}
}
|
;
commands:
commands command
| command
;
command: 
identifier ASSIGN expression ';'
| IF condition THEN commands ELSE commands ENDIF
| IF condition THEN commands ENDIF
| WHILE condition DO commands ENDWHILE
| DO commands WHILE condition ENDDO
| FOR PIDENTIFIER FROM value TO value DO commands ENDFOR
| FOR PIDENTIFIER FROM value DOWNTO value DO commands ENDFOR
| READ identifier ';'
| WRITE value ';'
;
expression:
value
| value '+' value
| value '-' value
| value '*'value
| value '/' value
| value '%' value
;
condition:
value EQ value
| value NE value
| value LW value
| value GR value
| value GRE value
| value LWE value
;
value:
NUM
| identifier
;
identifier:
PIDENTIFIER
| PIDENTIFIER '(' PIDENTIFIER ')'
| PIDENTIFIER '(' NUM ')'
;

%%

structures createNum(){
	structures s;
	s.type = "NUM";
	return s;
}
structures createArray(long long int start,long long int end){
	structures s;
	s.type = "ARR";
	s.end = end;
	s.start = start;
	s.size = abs(start)-abs(end)+1;
	return s;
}

void yyerror (char const *s){
	/*if (*s=='1')
		fprintf (stderr, "Divide by 0\n");
	if (*s=='2')
		fprintf (stderr, "a % b should b > 0\n");
	else
		fprintf (stderr, "Error\n");*/
}

int main(int argc, char** argv) {
	//yydebug = 1;

	extern FILE * yyin; 
	FILE *myfile = fopen(argv[1], "r");

	if (!myfile) {
		printf( "I can't open InputFileHTML.html");
		return -1;
	}

	yyin = myfile;
	yyparse();

}
