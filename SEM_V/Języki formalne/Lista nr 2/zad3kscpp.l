%{
#include <iostream>
using namespace std;
extern int yylex();
bool flag = false;
%}
%x comment doc
%option noyywrap
%%
\/{2}.*			;

\/\*\*([^\/\n]*)$		 %{if(flag==true) ECHO; BEGIN(doc);%}
<doc>[^\*\n]*        %{if(flag==true) ECHO;%}
<doc>\*+[^\*\/\n]*   %{if(flag==true) ECHO;%}
<doc>\*+\/        	 %{if(flag==true) ECHO; BEGIN(INITIAL);%}	

\/\*          	BEGIN(comment);
<comment>[^\*\n]*        ;/* eat anything that's not a '*' */
<comment>\*+[^\*\/\n]*   ;/* eat up '*'s not followed by '/'s */
<comment>\*+\/        BEGIN(INITIAL);
			
%%
int main(int argc, char* argv[]) {
	const char option = 'd';
	if(argc > 1){
		if(*(argv[1]) == option){
			flag = true;
		}
	}
	FILE *myfile = fopen("InputFile.c", "r");

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