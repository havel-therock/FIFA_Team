#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>


typedef struct element{
	int value;
	struct element* next;
	struct element* previous;
} Node;

typedef struct oneWayList{
	Node* head;
	Node* tail;
} List;



//isListNull() - sprawdzenie, czy kolejka ma jakieś elementy
bool isListNull(List* a){
	if(a->head == NULL){
		 return true;
	}else{
		return false;
	}
}

//giveSize() - zwrócenie liczby elementów na kolejce
int giveSize(List* a){
	if(isListNull(a)){
		return 0;
	}
	int size = 1;
	Node* b = a->head;
	while(b->next != NULL){
		size++;
		b = b->next;
		//printf("%d\n",b->value);
	}
	return size;
}

//deleteNode() - usunięcie wezla po wartosci
void deleteValue(List* a, int d_value){
  if(isListNull(a)){
    printf("List is Null");
		return;
	}
  Node* seeker = a->head;
  int size = giveSize(a);

  for(int i = 1; i < size; i++){
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
    if(i != (size - 1)){
      seeker = seeker->next;
    }
  }

  if(d_value == seeker->next->value){
    if(size == 1){
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

// usuwanie wezla po indeksie
void deleteIndex(List* a, int d_index){
  if(isListNull(a)){
    printf("List is Null");
		return;
	}
  int size = giveSize(a);
  if(size/2>=d_index){
	  Node* seeker = a->head;
	  for(int i = 1; i < size/2+1; i++){

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
		seeker -> next -> previous = help;
		free(seeker);
		return;
	      }
	    }
	    if(i != (size/2)){
	      seeker = seeker->next;
	    }
	  }
  }
  else if(size/2 < d_index && d_index <= size){
	Node* seeker = a->tail;
	 if(d_index == size){
	    if(size == 1){
	      free(seeker);
	      a->head = NULL;
		return;
	    }else {
	      a->tail = seeker->previous;
	      a->tail->next = NULL;
	      free(seeker);
		return;
	    }
	}
	 seeker = seeker->previous;
	  for(int i = size-1; i > size/2; i--){

	    if(i == d_index){
		Node* help = a->tail;
		int j = size-1;
		while(j > i){
		  help = help->previous;
		  j--;
		}
		help->previous = seeker->previous;
		seeker-> previous -> next = help;
		free(seeker);
		return;	      
	    }
	      seeker = seeker->previous;
	  }
  }
  else
	  printf("There is no element with this index\n");
	  
}


//addNode(wartość) - dodanie elementu do kolejki
void addNode(int newNode, List* a){
	Node* b = (Node*)malloc(sizeof(struct element));
	b->value = newNode;
	b->next = NULL;
	if(a->head == NULL){
		a->head = b;
		a->tail = b;
		b->previous=NULL;
	}else{
		b->previous=a->tail;
		a->tail->next = b;
		a->tail = b;
	}
}

//addNodeToHead(wartość) - dodanie elementu do kolejki od strony heada
void addNodeToHead(int newNode, List* a){
	Node* b = (Node*)malloc(sizeof(struct element));
	b->value = newNode;
	b->previous = NULL;

	if(a->head == NULL){
		a->head = b;
		a->tail = b;
		b->next=NULL;
	}else{
		
		b->next=a->head;
		a->head->previous = b;
		a->head = b;
	}
	
}

// seekValue() - zwracanie indeksu szukanej wartosci
int seekValue(List* a, int s_value){

	if(isListNull(a)){
		printf("Queue is Null\n");
		return -55555;
	}
  int size = giveSize(a);
  Node* seeker = a->head;
	for(int i = 1; i < size; i++){
    if(seeker->value == s_value){
      return i;
    }else{
      seeker = seeker->next;
    }
  }
  if(seeker->value == s_value){
    return size;
  }else{
    //printf("There is no such element\n");
    return -55555;
  }
}

//seekIndex() - zwracaie wartosi szukanego indeksu
int seekIndex(List* a, int s_index){

 if(isListNull(a)){
	printf("List is Null\n");
	return -55555;
 }
  int size = giveSize(a);

  if(size/2>=s_index){
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
  else if(size/2 < s_index && s_index <= size){
	 Node* seeker = a->tail;
	    for(int i = size; i > s_index; i--){
		    if(i == s_index){
		      return seeker->value;
	    }else{
	      seeker = seeker->previous;
	    }
	  }
  	return seeker->value;
  }
  else{
    printf("There is no such index\n");
    return -55555;
  }

}

//showList() - pokazywanie listy
void showList(List* a){
  if(isListNull(a)){
    printf("List is Null \n");
  }else{
	int size = giveSize(a);
    Node* displayer = a->head;
    for(int i = 1; i < size; i++){
      printf("%d ", displayer->value);
      displayer = displayer->next;
    }
    printf("%d\n", displayer->value);
  }
}

//merge() - laczenie dwoch list
List* merge(List* a, List* b){
  int size1=giveSize(a);
  int size2=giveSize(b);
  Node* seeker = a->head;
  List* mergeList = (List*)malloc(sizeof(List));
  for (int i=1; i<size1;i++){
	addNode(seeker->value,mergeList);
	seeker = seeker->next;
  }
  addNode(seeker->value,mergeList);
  seeker = b->head;
  for (int i=1; i<size2+1;i++){
	addNode(seeker->value,mergeList);
	seeker = seeker->next;
  }
  if(b!=a){
  	free(b);
  	free(a);
  }
  else
	free(b);
  return mergeList;
}

int main(){

List* a = (List*)malloc(sizeof(List));
	a->head = NULL;
	a->tail = a->head;

  List* b = (List*)malloc(sizeof(List));
	b->head = NULL;
	b->tail = b->head;

  srand(time(NULL));
  clock_t time1,time2;
  int attempts = 1000;

  for(int i = 1; i <=1000; i++){
    addNode(rand()%10001,a);
  }
  time1=clock();
  for(int i = 1; i <=attempts; i++){
			seekIndex(a,700);
  }
  time2=clock();

  printf("Average time for the same element %lfms \n", ((float)(time2-time1)/ 1000000.0F)*1000);

  time1=clock();
  for(int i = 1; i <=attempts; i++){
			seekIndex(a,rand()%1001);
  }
	time2=clock();
  printf("Average time for the random element %lfms \n", ((float)(time2-time1)/ 1000000.0F)*1000);
/*
List* testListc = (List*)malloc(sizeof(List));

	List* testList = (List*)malloc(sizeof(List));
	testList->head = NULL;
	testList->tail = testList->head;

  List* testListB = (List*)malloc(sizeof(List));
	testListB->head = NULL;
	testListB->tail = testListB->head;
	addNode(5,testList);
	addNode(10,testList);
	addNode(7,testList);
	addNode(6,testList);
	addNode(3,testList);
	addNode(9,testList);

	//testListc=merge(testList,testListB);
	showList(testList);
	deleteIndex(testList,5);
	 showList(testList);
	addNodeToHead(90,testList);
 	 showList(testList);
	deleteIndex(testList,2);

 	 showList(testList);


  //showList(testList);
  /*addNode(3,testList);
  addNode(2,testList);
  addNode(1,testList);
  addNode(4,testList);

  addNode(5,testListB);
  addNode(6,b);
  addNode(7,testListB);
  addNode(8,testListB);
  showList(testList);
  showList(testListB);
  merge(testList,testListB);
  showList(a);
  deleteIndex(testList,7);
  showList(testList);
  deleteValue(testList,7);
  showList(testList);
  deleteValue(testList,1);*/
  //showList(testList);

  return 0;
}
