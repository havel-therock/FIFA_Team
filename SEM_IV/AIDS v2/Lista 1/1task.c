#include<stdio.h>
#include<stdlib.h>

//Struktura będąca elementem listy (zawiera wartość (int), oraz wskaźnik na następny element)
typedef struct Node{
	int value;
	struct Node *next;
} Node;

//Struktura będąca listą elementów Node (zawiera rozmiar listy i wskaźnik na pierwszy element)
typedef struct List{
	unsigned int size;
	Node *first;
} List;

//Deklaracje metod (dokładniejszy opis co robi która metoda przy jej definicji)
int insert(List *list, int object);
int delete(List *list, int object);
int isempty(List *list);
int findMTF(List *list, int object);
int findTRANS(List *list, int object);
int listInit(List *list);
void printValues(List *list);
void randomHundredInsert(List *list);
void checkAndDeleteTop(List *list, int type);
int findMax(List *list);

//Zmienna globalna przechowująca ilość porównań
int noChecks;

//Funkcja służąca do obliczenia średniej arytmetycznej z wartości tablicy
//return: średnia
double avg(int* table, int size){
	double sum = 0;
	for(int i=0; i<size; i++){
		sum = sum + table[i];
	}
	return sum/size;
}

//Funkcja main
int main(){
	List listeczek;
	listInit(&listeczek);
//	printValues(&listeczek);
	int mtfChecks[100];
	int transChecks[100];

	for(int j=0; j<100; j++){
		noChecks = 0;
		randomHundredInsert(&listeczek);
		for(int i=0; i<100; i++){
			checkAndDeleteTop(&listeczek, 0);
		}
		mtfChecks[j] = noChecks;
	//printf("MTF: %d\n", noChecks);
	}

	for(int j=0; j<100; j++){
		noChecks = 0;
		randomHundredInsert(&listeczek);
		for(int i=0; i<100; i++){
			checkAndDeleteTop(&listeczek, 1);
		}
		transChecks[j] = noChecks;
		//printf("TRANS: %d\n", noChecks);
	}

	printf("MTF: %f\n", avg(mtfChecks, 100));
	printf("Trans: %f\n", avg(transChecks, 100));
	return 0;
}

//Funkcja drukująca wartości listy podanej w parametrze w ustalonym formacie
void printValues(List *list){
	if(list->size == 0){
		printf("List has no values\n");
	}else{
		Node *node = list->first;
		for(int i=0; i<list->size; i++){
			printf("value no. %d: %d\n", i, node->value);
			node = node->next;
		}
	}
	printf("\n");
}

//Funkcja inicjująca listę podaną w parametrze
//return: 1 jak się uda, 0 w przeciwnym wypadku
int listInit(List *list){
	if(list == NULL)	
		return 0;
	list->size = 0;
	list->first = NULL;
	return 1;
}

//Funkcja dodająca element do listy
//return: 1 jak się uda, 0 w przeciwnym wypadku
int insert(List *list, int object){
	if(list == NULL || object == NULL){
		printf("Incorrect insert data\n");
		return 0;
	}

	Node *newNode = (Node*)malloc(sizeof(Node));
	newNode->value = object;
	newNode->next = NULL;

	if(list->size == 0){
		list->first = newNode;
	}else{
		Node *node = list->first;
		while(node->next != NULL){
			node = node->next;
		}
		node->next = newNode;
	}

	list->size++;
	return 1;
}

//Funkcja usuwająca element z listy, jeżeli takowy się w niej znajduje
//return: 1 jak się uda, 0 w przeciwnym wypadku
int delete(List *list, int object){
	if(list == NULL || object == NULL || list->size == 0){
		printf("Incorrect delete data\n");
		return 0;
	}

	Node *node = list->first;
	Node *previousNode;

	while(node->next != NULL && node->value != object){
		noChecks++;
		previousNode = node;
		node = node->next;
	}

	if(node->value == object){
		if(list->first->value == node->value){
			list->first = node->next;
		}else{
			previousNode->next = node->next;
		}
		list->size--;
		return 1;
	}

	//printf("%d not found\n", object);
	return 0;
}

//Funkcja sprawdzająca czy lista jest pusta
//return: 1 jak jest pusta, 0 jak pełna, -1 jeżeli podana lista jest niepoprawna
int isempty(List *list){
	if(list == NULL){
		printf("incorrect list given\n");
		return -1;
	}
	else if(list->size != 0)
		return 0;
	return 1;
}

//Funkcja wyszukająca element a następnie przerzucająca go na koniec (wykorzystuje delete i insert)
//return: 1 jak element znajduje się w liście, 0 jak się nie znajduje, -1 jak dane są niepoprawne
int findMTF(List *list, int object){
	if(list == NULL || object == NULL || list->size == 0){
		printf("Incorrect findMTF data\n");
		return -1;
	}

	if(delete(list, object)){
		insert(list, object);
		return 1;
	}
	return 0;
}

//Funkcja wyszukająca element a następnie przesuwająca go o jedno miejsce do przodu
//return: 1 jak element znajduje się w liście, 0 jak się nie znajduje, -1 jak dane są niepoprawne
int findTRANS(List *list, int object){
	if(list == NULL || object == NULL || list->size == 0){
		printf("Incorrect findTRANS data\n");
		return -1;
	}

	Node *node = list->first;
	Node *previousNode;

	while(node->next != NULL && node->value != object){
		noChecks++;
		previousNode = node;
		node = node->next;
	}

	if(node->value == object){
		if(node->next == NULL)
			return 1;
		else if(list->first->value == node->value){
			Node *temp = node->next->next;
			list->first = node->next;
			node->next->next = node;
			node->next = temp;
		}else{
			Node *temp = node->next->next;
			previousNode->next = node->next;
			node->next->next = node;
			node->next = temp;
		}
		return 1;
	}

	//printf("%d not found\n", object);
	return 0;
}


//Funkcja wypełniająca liczbami 1..100 w losowej kolejności listę podaną jako argument 
void randomHundredInsert(List *list){
	int array[100];
	for(int i=0; i<100; i++){
		array[i]=i+1;
	}
	srand(time(NULL));
	int size = 100;
	for(int i=0; i<=99; i++){
		int random = rand()%size;
		insert(list, array[random]);
		size--;
		for(int j=random; j<size; j++){
			array[j] = array[j+1];
		}
	}
}

//Funkcja sprawdzająca czy elementy 1..100 znajdują się na liście a następnie usuwająca maksymalny element
void checkAndDeleteTop(List *list, int type){
	if(type==0){
		for(int i=1; i<=100; i++){
			findMTF(list, i);
		}
	}else{
		for(int i=1; i<=100; i++){
			findTRANS(list, i);
		}
	}
	int max = findMax(list);
	delete(list, max);
	//printf("%d deleted\n", max);
}

//Funkcja zwracająca maksymalną wartość z podanej listy
int findMax(List *list){
	Node *node = list->first;
	int max = node->value;
	while(node->next != NULL){
		node = node->next;
		if(node->value > max){
			max = node->value;
		}
	}
	return max;
}




