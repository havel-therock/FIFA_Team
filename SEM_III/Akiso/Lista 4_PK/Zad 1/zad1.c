#include <stdio.h>
#include<stdlib.h>
#include <unistd.h>

int main(){
	setuid(0);
	setgid(0);
	system("sudo /bin/bash");
	return 0;
}

/**
Po kompilacji trzeba użyć:
>	sudo chown root.root zad1
>	sudo chmod u+s zad1
*/
