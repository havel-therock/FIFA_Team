//
//  zad1.c
//  
//
//  Created by Niebieski-Kapturek on 27.02.2018.
//

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

//add(element) - dodanie elementu do kolejki
void add(int newMember, struct queue* a){
    struct element* b = (struct element*)malloc(sizeof(struct element));
    (*b).value = newMember;
    (*b).next = NULL;
    if((*a).head == NULL){
        (*a).head = b;
        (*a).tail = b;
    }else{
        (*(*a).tail).next = b;
        (*a).tail = b;
    }
}

//check_null() - sprawdzenie, czy kolejka jest pusta
bool check_null(struct queue *a){
    if((*a).head == NULL){
        return true;
    }else{
        return false;
    }
}

//get_size() - zwrócenie liczby elementów na kolejce
int get_size(struct queue* a){
    if(check_null(a)){
        return 0;
    }
    int size = 1;
    struct element* b = (*a).head;
    while((*b).next != NULL){
        size++;
        b = (*b).next;
    }
    return size;
}

//get_value() - zwrocenie pierwszego elementu z kolejki
int get_value(struct queue *a){
    if(check_null(a)){
        printf("pusto\n");
        return -1234;
    }
    return (*(*a).head).value;
}

//remove_element() - usunięcie elementu z kolejki
void remove_element(struct queue* a){
    if(check_null(a)){
        return;
    }
    struct element* b = (*(*a).head).next;
    
    free((*a).head);
    (*a).head = b;
}

int main(){
    
    //tworzenie kolejki:
    struct queue *a = (struct queue*)malloc(sizeof(struct queue));
	(*a).head = NULL;
	(*a).tail = (*a).head;
	printf("\nUtworzono pusta kolejke\n");		
    //koniec tworzenia
    
    if(check_null(a)){
        printf("Kolejka jest pusta!\n");
    }else{
        printf("Kolejka NIE jest pusta.\n");
    }
    
    add(7,a);
    printf("\nDodano element wartosci 7\n");
    if(check_null(a)){
        printf("Kolejka jest pusta!\n");
    }else{
        printf("Kolejka NIE jest pusta.\n");
    }
    
    printf("Wartosc heada: %d\n",get_value(a));
    
    printf("Rozmiar kolejki: %d\n",get_size(a));
    
    add(2,a);
    printf("\nDodano element wartosci 2\n");

    if(check_null(a)){
        printf("Kolejka jest pusta!\n");
    }else{
        printf("Kolejka NIE jest pusta.\n");
    }
    
    printf("Wartosc heada: %d\n",get_value(a));
    printf("Rozmiar kolejki: %d\n",get_size(a));
    
    remove_element(a);
    printf("\nUsunieto(zabrano) element\n");
    
    if(check_null(a)){
        printf("Kolejka jest pusta!\n");
    }else{
        printf("Kolejka NIE jest pusta.\n");
    }
    
    printf("Wartosc heada: %d\n",get_value(a));
    printf("Rozmiar kolejki: %d\n",get_size(a));
    
    remove_element(a);
    printf("\nUsunieto(zabrano) element\n");
    
    if(check_null(a)){
        printf("Kolejka jest pusta!\n");
    }else{
        printf("Kolejka NIE jest pusta.\n");
    }
    
    printf("Wartosc heada: %d\n",get_value(a));
    printf("Rozmiar kolejki: %d\n",get_size(a));
    
    remove_element(a);
    printf("\nUsunieto(zabrano) element\n");    

    if(check_null(a)){
        printf("Kolejka jest pusta!\n");
    }else{
        printf("Kolejka NIE jest pusta.\n");
    }
    
    printf("Wartosc heada: %d\n",get_value(a));
    printf("Rozmiar kolejki: %d\n",get_size(a));
    
    add(3,a);
    printf("\nDodano element wartosci 3\n");
    
    if(check_null(a)){
        printf("Kolejka jest pusta!\n");
    }else{
        printf("Kolejka NIE jest pusta.\n");
    }
    
    printf("Wartosc heada: %d\n",get_value(a));
    printf("Rozmiar kolejki: %d\n",get_size(a));
    
    return 0;
}

