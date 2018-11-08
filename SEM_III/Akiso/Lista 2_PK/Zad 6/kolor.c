#include <stdio.h>

int main(){
	for(int i=30;i<=37;i++){
		printf("\x1b[%im Hello, World!\n", i);
	}
	for(int i=30;i<=37;i++){
		printf("\x1b[1;%im Hello, World!\n", i);
	}
	return 0;
}