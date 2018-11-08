#include <signal.h>
#include <stdio.h>

int sig_number=0;

void sig_action(int n){
		
	sig_number++;
	printf("odebrano	%d",n);
}

int main(){

	signal(SIGUSR1, sig_action);

	for(int i=0;i<10;i++){
		kill(getpid(), SIGUSR1);
		printf("	%d\n", sig_number);
	}

	return 0;
}
