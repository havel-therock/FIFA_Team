#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

int main(){
	printf("dla SIGKILL:\n");
	system("kill -9 1");
	printf("dla SIGUSR2:\n");
	system("kill -12 1");
	printf("dla SIGRTMIN+2:\n");
	system("kill -36 1");
	printf("dla SIGRTMAX-4:\n");
	system("kill -60 1");
	return 0;
}
//dla root działa !!!
