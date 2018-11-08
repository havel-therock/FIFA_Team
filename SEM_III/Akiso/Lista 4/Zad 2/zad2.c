#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

int main(){
	for(int i=1;i<=64;i++){
		struct sigaction old, new;
		if(sigaction(i,&new,&old)==0){
			printf("%d - obsłużono\n",i);
		}
		else if(i==9 || i==19){
			printf("%d - sygnał nie mogże być przechwycony\n",i);
		}
		else if(sigaction(i,&new,&old)==(-1)){
			printf("%d - błąd\n",i);
		}
	}
	return 0;
}
