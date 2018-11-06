%{
#include <iostream>
using namespace std;
extern int yylex();
int wordNum = 0, lineNum = 0;
%}
%option noyywrap
%%
^([^ \t\n]+)              %{ECHO; wordNum++; /*case: |word	count end rewrite word*/%} 
^([ \t]+)                 %{ wordNum++; /*case: |whitespaces->word	count word*/%} 
^([ \t]*\n)               ;/*ignore empty line*/
\n                        %{fprintf(yyout, "\n"); lineNum++; /*count line*/%}
[ \t]+\n                  %{fprintf(yyout, "\n"); lineNum++; /*case: word->whitespaces|  replace whitespaces with \n and count line*/%}
[ \t]+                    %{fprintf(yyout, " "); wordNum++; /*count word and replace multiple whitespaces*/%}
.                           ECHO; /* rewrite any other char*/


%%
int main(int, char**) {

	FILE *myfile = fopen("InputFile.txt", "r");

	if (!myfile) {
		cout << "I can't open InputFile.txt" << endl;
		return -1;
	}
	
	yyin = myfile;

    FILE *myfile2 = fopen("OutputFile.txt", "wb");
	
	if (!myfile2) {
		cout << "I can't open OutputFile.txt" << endl;
		return -1;
	}
	
	yyout = myfile2;

  // lex through the input:
  while (yylex());
  cout << "# word = " << wordNum << endl; 
  cout << "# line = " << lineNum << endl;
  return 0;
}