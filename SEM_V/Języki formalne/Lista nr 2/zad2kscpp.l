%{
#include <iostream>
using namespace std;
extern int yylex();
%}
%x quote
%option noyywrap
%%
\<[^\"]*[a-zA-Z]+\=\"{1}			%{ECHO; BEGIN(quote);%}	
<quote>[^\"]*   					%{ECHO; %}
<quote>\"[^\"]*>					%{ECHO; BEGIN(INITIAL);%}

\<!--([^-]|-[^-]|--+[^-\>])*-*--\>		fprintf(yyout, "");
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
