#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

struct v{
	int i; //row
	int j; //column
};

void *runner(void *param); //thread

int K1,M1,N1;
int **A;
int **At; //macierz transpozycjonowana
int **B;
int **C;

int main(int argc, char *argv[]){
	int i,j,count=0;
	int M,K,N;
	int NUM_THREADS;

	printf("Podaj ilość wierszy macierzy1: ");
	scanf("%d", &M);
	M1 = M;
	printf("Podaj ilość kolumn macierzy1: ");
	scanf("%d", &K);
	K1 = K;
	printf("Podaj ilość wierszy macierzy2: %d\n", K);
	printf("Podaj ilość kolumn macierzy2: ");
	scanf("%d", &N);
	N1 = N;
	printf("Podaj ilość kolumn watkow: ");
	scanf("%d", &NUM_THREADS);

	A = malloc(M * sizeof *A);
	B = malloc(K * sizeof *B);
	C = malloc(M * sizeof *C);

	for (i=0;i<M;i++){
    		A[i] = malloc(K * sizeof *A[i]);
  	}
	for (i=0;i<K;i++){
    		B[i] = malloc(N * sizeof *B[i]);
  	}
	for (i=0;i<M;i++){
    		C[i] = malloc(N * sizeof *C[i]);
  	}
	
	At = malloc(K * sizeof *At);	
	for (i=0;i<K;i++){
    		At[i] = malloc(M * sizeof *At[i]);
  	}

	//wypelnianie i drukowanie macierzy
	printf("\nMacierz 1:\n");
	for(i=0;i<M;i++){
		for(j=0;j<K;j++){
			A[i][j] = ( rand() % 2 );
			printf("%d ", A[i][j]);
		}
		printf("\n");
	}
	printf("\nMacierz 2:\n");
	for(i=0;i<K;i++){
		for(j=0;j<N;j++){
			B[i][j] = ( rand() % 2 );
			printf("%d ", B[i][j]);
		}
		printf("\n");
	}
	printf("\nMacierz 1 po transpozycji:\n");
	for(i=0;i<K;i++){
		for(j=0;j<M;j++){
			At[i][j] = A[j][i];
			printf("%d ", At[i][j]);
		}
		printf("\n");
	}	

	for(i=0;i<M;i++){
		for(j=0;j<N;j++){
			//
			struct v *data = (struct v *) malloc(sizeof(struct v));
			data->i=i;
			data->j=j;
			//tworzenie wątków
			pthread_t tid; //id wątka
			pthread_attr_t attr; //atrybut wątka
			//przypisanie domyślnego atrybutu
			pthread_attr_init(&attr);
			//tworzy wątek
			pthread_create(&tid, &attr, runner, data);
			//upewnienie że rodzic czeka na zakonczenie wszystkich wątków
			pthread_join(tid, NULL);
			count++;
		}
	}

	//drukowanie macierzy wynikowej
	printf("\nMacierz 1 * Macierz 2:\n");
	for(i=0;i<M;i++){
		for(j=0;j<N;j++){
			printf("%d ", C[i][j]);
		}
		printf("\n");
	}
}

//obsługa wątka
void *runner(void *param){
	struct v *data = param;
	int n, sum=0;

	//mnożenie kolumna * kolumna
	for(n=0;n<K1;n++){
		sum += At[n][data->i] * B[n][data->j];
	}
	if(sum>=1){
		sum = 1;
	}
	//wstawianie wyniku mnożenia do macierzy
	C[data->i][data->j] = sum;
	//zamyka wątek
	pthread_exit(0);
}
