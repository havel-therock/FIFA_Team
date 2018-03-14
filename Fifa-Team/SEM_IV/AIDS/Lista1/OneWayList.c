#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct Element {
	int number;
	struct Element *next;
} Element;

void add(Element** list, Element* new) {
	new->next = NULL;
	
	if((*list) == NULL) {
		*list = new;
	}
	else {
		Element *pointer = *list;
		while((pointer->next) != NULL) {
			pointer = pointer->next;
		}
		pointer->next = new;
	}
}

void addElement(Element** list, int i) {
	Element *new = (Element*)malloc(sizeof(Element));
		(new->number) = i;
		add(list, new);
}

void printList(Element* list) {
	Element *pointer = list;
	if(list == NULL) {
		printf("-------------\n"
			   "FIFO is empty\n"
			   "-------------\n");
	}
	else {
		while(pointer != NULL) {
			printf("----\n%d\n----\n", (pointer->number));
			pointer = pointer->next;
		}
	}
}

int lengthList(Element* list) {
	int l = 0;
	Element *pointer = list;
	while(pointer != NULL) {
		l++;
		pointer = pointer->next;
	}
	return l;
}

void deleteElement(Element** list) {
	Element *pointer = *list;
	*list = (*list)->next;
	free(pointer);
}

void seekElement(Element* list, int index) {
	if((index > lengthList(list)) || (index < 1)) {
		printf("Error: Wrong Data\n");
	}
	else {
		Element* pointer = list;
		for(int i = 0; i < index; i++) {
			pointer = pointer->next;
		}
	}
}

void merge(Element* list, Element* list2, Element* listH) {
	addElement(&listH, 0);
	Element *pointer = listH;
	while(list && list2) {
		if(list->number > list2->number) {
			pointer->next = list2;
			list2 = list2->next;
		}
		else {
			pointer->next = list;
			list = list->next;
		}
		pointer = pointer->next;
	}
	while(list) {
		pointer->next = list;
		list = list->next;
		pointer = pointer->next;
	}
	while(list2) {
		pointer->next = list2;
		list2 = list2->next;
		pointer = pointer->next;
	}
	deleteElement(&listH);
}

int main() {
	Element *list = NULL;
	int i, option, index, random;
	clock_t start_t, stop_t, total_t;
	srand (time(NULL));
	
	Element *list2 = NULL;
	Element *listH = NULL;
	
	
	for(i = 0; i <= 10; i++) {
		addElement(&list, i);
	}
	printList(list);
	
	/*for(i =0; i < 20; i=i+2) {
		addElement(&list2, i);
	}
	
	merge(list, list2, listH);
	printList(list);
	*/
	
	while(option != 1){
		printf("Seek Element: ");
		scanf("%d", &index);
		start_t = clock();
		for(i = 0; i < 1000000; i++) {
			seekElement(list, index);
		}	
		stop_t = clock();
		total_t = (stop_t - start_t);
		double total = (double)total_t/CLOCKS_PER_SEC;
		printf("Total Time: %f\n", total);
		printf("Do you want test again? 0/1\n");
		scanf("%d", &option);
	}
	
	
	/*printf("Seek random Elements\n");
	start_t = clock();
	for(i= 0; i < 1000000; i++) {
		random = rand() % 1000 + 1;
		seekElement(list, random);
	}
	stop_t = clock();
	total_t = (stop_t - start_t);
	double total = (double)total_t/CLOCKS_PER_SEC;
	printf("Total Time: %f\n", total);
	*/
	
	printf("-------------\n"
		   "Thanks 4 use\n"
		   "By Mateusz Laskowski\n");
	return 0;
} 