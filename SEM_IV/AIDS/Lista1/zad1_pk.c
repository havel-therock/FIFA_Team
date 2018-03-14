#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

struct Part{
	int value;
	struct Part* next;
};

struct List{
	struct Part* head;
	struct Part* tail;
	int size;
};

bool empty(struct List* x){
	if(x->head==NULL){
		return true;
	}else{
		return false;
	}
}

struct List* push(int newValue, struct List* x){
	struct Part* y = malloc(1 * sizeof(*y));
	y->value = newValue;
	y->next = NULL;
	
	if(empty(x)){
		x->head = y;
		x->tail = y;
		x->size++;
		return x;
	}
	else{
		x->tail->next = y;
		x->tail = y;
		x->size++;
	}
	printf("Value %d was added.\n", newValue);
	return x;
}

struct List* pop(struct List* x){
	if(empty(x)){
		return x;
	}
	struct Part* p1 = NULL;
	struct Part* p2 = NULL;
	p1 = x->head;
	p2 = p1->next;
	free(p1);
	x->head = p2;
	x->size--;
	if(empty(x)){
		x->tail = x->head;
		x->size = 0;
	}
	printf("Value was removed.\n");
	return x;
}

void size(struct List* x){
	printf("Size: %d\n",x->size);
}

void firstValue(struct List* x){
	if(empty(x)){
		printf("There is no value. List is empty.\n");
	}
	else{
		printf("Value: %d\n",x->head->value);
	}
}

int main (int argc, char *argv[]){
	//Tworzenie listy
	struct List*  list = malloc( 1 * sizeof(*list));
	list->head = NULL;
	list->tail = NULL;
	list->size = 0;
	
	push(4,list);
	firstValue(list);
	push(3,list);
	size(list);
	pop(list);
	firstValue(list);
	size(list);
	push(9,list);
	push(6,list);
	size(list);
	firstValue(list);
	pop(list);
	pop(list);
	pop(list);
	size(list);
	firstValue(list);
	
	return 0;
}
