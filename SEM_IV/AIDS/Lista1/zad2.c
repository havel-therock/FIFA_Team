#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>

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

void create(struct List* x){
	x->head = NULL;
	x->tail = NULL;
	x->size = 0;
}

void fill(struct List* x, int n){
	for(int i=0;i<n;i++){
		push(rand(),x);
	}
}

void goTo(struct List* x, int n){
	if((n > 0) && (n <= x->size)){
		struct Part* p = NULL;
		p = x->head;
		for(int i=n;i>0;i--){
			p = p->next;
		}
	}
	else{
		printf("Wrong index\n");
	}
}

void merge(struct List* x,struct List* y,struct List* z){
	struct Part* mX = NULL;
	struct Part* mY = NULL;
	mX = x->head;
	mY = y->head;
	
	while(mX && mY){
		if(mX->value < mY->value){
			push(mX->value,z);
			mX = mX->next;
		}
		else{
			push(mY->value,z);
			mY = mY->next;
		}
	}
	while(mX){
		push(mX->value,z);
		mX = mX->next;
	}
	while(mY){
		push(mY->value,z);
		mY = mY->next;
	}
	free(mX);
	free(mY);
	free(x);
	free(y);
}

void show(struct List* x){
	struct Part* b = x->head;
	while(b != NULL){
		printf("%d, ",b->value);
		b = b->next;
	}
	printf("\n");
}

int main (int argc, char *argv[]){
	double ti;
	clock_t start_t, end_t, total_t;
	time_t t;
	int r, s;
	s = time(&t);
	srand(s);
	//Tworzenie listy
	struct List*  list = malloc( 1 * sizeof(*list));
	create(list);
	fill(list,1000);
	
	size(list);
	
	//Testy dla 500 elementu listy
	start_t = clock();
	for(int i=0;i<1000000;i++){
		goTo(list,500);
	}
	end_t = clock();
	total_t = end_t - start_t;
	ti = (double)total_t/CLOCKS_PER_SEC;
	printf("Time for 500-th element: %f s\n",ti);
	printf("Average time: %f\n",ti/1000000);
	
	//Testy dla 145 elementu listy
	start_t = clock();
	for(int i=0;i<1000000;i++){
		goTo(list,145);
	}
	end_t = clock();
	total_t = end_t - start_t;
	ti = (double)total_t/CLOCKS_PER_SEC;
	printf("Time for 145-th element: %f s\n",ti);
	printf("Average time: %f\n",ti/1000000);
	
	//Testy dla 999 elementu listy
	start_t = clock();
	for(int i=0;i<1000000;i++){
		goTo(list,999);
	}
	end_t = clock();
	total_t = end_t - start_t;
	ti = (double)total_t/CLOCKS_PER_SEC;
	printf("Time for 999-th element: %f s\n",ti);
	printf("Average time: %f\n",ti/1000000);
	
	//Testy dla losowego elementu listy
	start_t = clock();
	for(int i=0;i<1000000;i++){
		r = 1 + (int)(rand() / (RAND_MAX + 1.0) * 1000);
		goTo(list,r);
	}
	end_t = clock();
	total_t = end_t - start_t;
	ti = (double)total_t/CLOCKS_PER_SEC;
	printf("Time for random element: %f s\n",ti);
	printf("Average time: %f\n",ti/1000000);
	
	//Marge
	struct List*  list1 = malloc( 1 * sizeof(*list1));
	create(list1);
	fill(list1,5);
	show(list1);
	struct List*  list2 = malloc( 1 * sizeof(*list2));
	create(list2);
	fill(list2,5);
	show(list2);
	struct List*  list3 = malloc( 1 * sizeof(*list3));
	create(list3);
	merge(list1,list2,list3);
	show(list3);
	
	return 0;
}