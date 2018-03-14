#include <stdio.h>
#include <stdlib.h>

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

void addElement(Element** list) {
	Element *new = (Element*)malloc(sizeof(Element));
	scanf("%d", &(new->number));
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

int main() {
	Element *list = NULL;
	int option;
	
	printf("Options\n");
	
	while(option != 0) {
		printf("0. Exit\n");
		printf("1. Add number\n");
		printf("2. Print FIFO\n");
		printf("3. Length FIFO\n");
		printf("4. Delete Element\n");
		
		scanf("%d", &option);
		
		switch(option) {
			case 1:
				addElement(&list);
				break;
				
			case 2:
				printList(list);
				break;
			
			case 3:
				printf( "------------\n"
						"length: %d\n"
						"------------\n", lengthList(list));
				break;
			
			case 4:
				deleteElement(&list);
			break;
		}
	}
	printf("Thanks 4 use\n"
		   "By Mateusz Laskowski\n");
	return 0;
} 
