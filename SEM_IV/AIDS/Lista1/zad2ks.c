#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>


typedef struct element{
	int value;
	struct element* next;
} Node;

typedef struct oneWayList{
	Node* head;
	Node* tail;
} List;


//addNode(wartość) - dodanie elementu do listy
//pop() - usunięcie elementu z kolejki
//empty() - sprawdzenie, czy kolejka jest pusta
//size() - zwrócenie liczby elementów na kolejce
//value() - zwrocenie pierwszego elementuz kolejki

void merge(List* a, List* b){
  a->tail->next = b->head;
  a->tail = b->tail;
  free(b);
}

bool empty(List* a){
	if(a->head == NULL){
		 return true;
	}else{
		return false;
	}
}

int size(List* a){
	if(empty(a)){
		return 0;
	}
	int size = 1;
	Node* b = a->head;
	while(b->next != NULL){
		size++;
		b = b->next;
	}
	return size;
}

void deleteValue(List* a, int d_value){
  if(empty(a)){
    printf("List is empty");
		return;
	}
  Node* seeker = a->head;

  for(int i = 1; i < size(a); i++){
    if(seeker->value == d_value){
      if(i == 1){
        seeker = a->head->next;
        free(a->head);
        a->head = seeker;
        return;
      }else{
        Node* help = a->head;
        int j = 2;
        while(j < i){
          help = help->next;
          j++;
        }
        help->next = seeker->next;
        free(seeker);
        return;
      }
    }
    if(i != (size(a) - 1)){
      seeker = seeker->next;
    }
  }

  if(d_value == seeker->next->value){
    if(size(a) == 1){
      free(seeker);
      a->head = NULL;
    }else{
      free(seeker->next);
      a->tail = seeker;
      a->tail->next = NULL;
    }
  }else{
    printf("There is no such element\n");
  }
}


void deleteIndex(List* a, int d_index){
  if(empty(a)){
    printf("List is empty");
		return;
	}
  Node* seeker = a->head;

  for(int i = 1; i < size(a); i++){

    if(i == d_index){
      if(i == 1){
        seeker = a->head->next;
        free(a->head);
        a->head = seeker;
        return;
      }else{
        Node* help = a->head;
        int j = 2;
        while(j < i){
          help = help->next;
          j++;
        }
        help->next = seeker->next;
        free(seeker);
        return;
      }
    }
    if(i != (size(a) - 1)){
      seeker = seeker->next;
    }
  }

  if(d_index == size(a)){
    if(size(a) == 1){
      free(seeker);
      a->head = NULL;
    }else{
      free(seeker->next);
      a->tail = seeker;
      a->tail->next = NULL;
    }
  }else{
    printf("There is no element with this index\n");
  }
}


void addNode(int newNode, List* a){
	Node* b = (Node*)malloc(sizeof(struct element));
	b->value = newNode;
	b->next = NULL;
	if(a->head == NULL){
		a->head = b;
		a->tail = b;
	}else{
		a->tail->next = b;
		a->tail = b;
	}
}



int seekValue(List* a, int s_value){
	if(empty(a)){
		printf("Queue is empty\n");
		return -34404;
	}
  Node* seeker = a->head;
	for(int i = 1; i < size(a); i++){
    if(seeker->value == s_value){
      return i;
    }else{
      seeker = seeker->next;
    }
  }
  if(seeker->value == s_value){
    return size(a);
  }else{
    //printf("There is no such element\n");
    return -34403;
  }
}

int seekIndex(List* a, int s_index){
  if(empty(a)){
		printf("List is empty\n");
		return -34404;
	}
  if(s_index > size(a)){
    printf("There is no such index\n");
    return -34404;
  }
  Node* seeker = a->head;
	for(int i = 1; i < s_index; i++){
    if(i == s_index){
      return seeker->value;
    }else{
      seeker = seeker->next;
    }
  }
  return seeker->value;
}

void display(List* a){
  if(empty(a)){
    printf("List is empty\n");
  }else{
    Node* displayer = a->head;
    for(int i = 1; i < size(a); i++){
      printf("%d ", displayer->value);
      displayer = displayer->next;
    }
    printf("%d\n", displayer->value);
  }
}


int main(){

	//prepare One Way Lists
	List* a = (List*)malloc(sizeof(List));
	a->head = NULL;
	a->tail = a->head;

  List* b = (List*)malloc(sizeof(List));
	b->head = NULL;
	b->tail = b->head;

  //prepare random number generator and clock
  srand(777); //time(NULL)
  int random;
  clock_t t;
  double averageTime;
  int attempts = 100;

  //end of prepare
  for(int i = 1; i <=1000000; i++){
    addNode(rand(),a);
  }

	t=clock();
  for(int i = 1; i <=attempts; i++){
    	//seekIndex(a,rand()%100000 + 1);
			seekIndex(a,999000);
  }
	t=clock()-t;

  printf("Average access time %lfms", ((float)t)/CLOCKS_PER_SEC/attempts*1000);

//  clock_t start = ((1000*clock())/CLOCKS_PER_SEC);
  // badaj Czas
    //seekValue(a,7);
  // stop
  //printf( "Czas wykonywania: %lu ms\n", clock() - start );



  //display(a);
  /*addNode(3,a);
  addNode(2,a);
  addNode(1,a);
  addNode(4,a);

  addNode(5,b);
  addNode(6,b);
  addNode(7,b);
  addNode(8,b);
  display(a);
  display(b);
  merge(a,b);
  display(a);
  deleteIndex(a,7);
  display(a);
  deleteValue(a,7);
  display(a);
  deleteValue(a,1);*/
  //display(a);

  return 0;
}
