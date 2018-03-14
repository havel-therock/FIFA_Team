#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

struct queue{
	struct element *head;
	struct element *tail;
};

struct element{
	int value;
	struct element *next;
};

//push(wartość) - dodanie elementu do kolejki
//pop() - usunięcie elementu z kolejki
//empty() - sprawdzenie, czy kolejka jest pusta
//size() - zwrócenie liczby elementów na kolejce
//value() - zwrocenie pierwszego elementuz kolejki

bool empty(struct queue *a){
	if(a->head == NULL){
		 return true;
	}else{
		return false;
	}
}

int size(struct queue* a){
	if(empty(a)){
		return 0;
	}
	int size = 1;
	struct element* b = a->head;
	while(b->next != NULL){
		size++;
		b = b->next;
	}
	return size;
}

void pop(struct queue* a){
	if(empty(a)){
		return;
	}
	struct element* b = a->head->next;
	//free(a->head->next);
	free(a->head);
	a->head = b;
}

void push(int newQueuer, struct queue* a){
	struct element* b = (struct element*)malloc(sizeof(struct element));
	b->value = newQueuer;
	b->next = NULL;
	if(a->head == NULL){
		a->head = b;
		a->tail = b;
	}else{
		a->tail->next = b;
		a->tail = b;
	}
}



int value(struct queue *a){
	if(empty(a)){
		printf("Queue is empty");
		return -34404;
	}
	return a->head->value;
}

int main(){

	//prepare queue
	struct queue *a = (struct queue*)malloc(sizeof(struct queue));
	a->head = NULL;
	a->tail = a->head;
	//end of prepare

	if(empty(a)){
		printf("EMPTY QUEUE!!!\n");
	}else{
		printf("Queue not empty.\n");
	}

	push(1,a);
							printf("push przeszedl\n");
	if(empty(a)){
		printf("EMPTY QUEUE!!!\n");
	}else{
		printf("Queue not empty.\n");
	}

	printf("%d\n",value(a));

	printf("%d\n",size(a));

	push(3,a);

	if(empty(a)){
		printf("EMPTY QUEUE!!!\n");
	}else{
		printf("Queue not empty.\n");
	}

	printf("%d\n",value(a));

	printf("%d\n",size(a));

	pop(a);

	if(empty(a)){
		printf("EMPTY QUEUE!!!\n");
	}else{
		printf("Queue not empty.\n");
	}

	printf("%d\n",value(a));

	printf("%d\n",size(a));

	pop(a);

	if(empty(a)){
		printf("EMPTY QUEUE!!!\n");
	}else{
		printf("Queue not empty.\n");
	}

	printf("%d\n",value(a));

	printf("%d\n",size(a));

	pop(a);

	if(empty(a)){
		printf("EMPTY QUEUE!!!\n");
	}else{
		printf("Queue not empty.\n");
	}

	printf("%d\n",value(a));

	printf("%d\n",size(a));

	push(3,a);

	if(empty(a)){
		printf("EMPTY QUEUE!!!\n");
	}else{
		printf("Queue not empty.\n");
	}

	printf("%d\n",value(a));

	printf("%d\n",size(a));

	return 0;
}
