%{
#include <iostream>
using namespace std;
extern int yylex();
%}

%option noyywrap
%%

\<!--([^-]|-[^-]|--+[^-\>])*-*--\>		fprintf(yyout, "");
--.*?--		fprintf(yyout, "");
.                                 		ECHO;
%%
int main(int, char**) {

	FILE *myfile = fopen("InputFileHTML.html", "r");

	if (!myfile) {
		cout << "I can't open InputFileHTML.html" << endl;
		return -1;
	}
	
	yyin = myfile;

    FILE *myfile2 = fopen("OutputFile.html", "wb");
	
	if (!myfile2) {
		cout << "I can't open OutputFile.html" << endl;
		return -1;
	}
	
	yyout = myfile2;

  // lex through the input:
  while (yylex());
  return 0;
}
