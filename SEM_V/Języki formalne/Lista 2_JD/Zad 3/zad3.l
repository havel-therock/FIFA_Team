%{
#include <iostream>
using namespace std;
extern int yylex();
bool flag = false;

%}
OPERATOR	"*"
%option noyywrap
%%
"//".*		/* Ignore one-line comments */
"//"(.*\\\n)*.*	/*Ignore "multi-line one-line comments" */


"/**/"
"/*"[^{OPERATOR}]+[.\n]*"*/"


%%
int main(int argc, char* argv[]) {
	const char option = 'd';
	if(argc > 1){
		if(*(argv[1]) == option){
			flag = true;
		}
	}
	FILE *myfile = fopen("test.c", "r");

	if (!myfile) {
		cout << "I can't open InputFile.c" << endl;
		return -1;
	}
	
	yyin = myfile;

    FILE *myfile2 = fopen("OutputFile.c", "wb");
	
	if (!myfile2) {
		cout << "I can't open OutputFile.c" << endl;
		return -1;
	}
	
	yyout = myfile2;

  // lex through the input:
  while (yylex());
 
  return 0;
}
