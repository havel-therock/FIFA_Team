#ifndef list_h
#define list_h

#include <stdio.h>
#include <stdlib.h>

extern int numberOfComparisons;

// struktura List - jedno kierunkowa lista
// value - przechowywana wartość
// *nextElement - wskaźnik na następny element
typedef struct List
{
    /* data of struct */
    int value;
    struct List *nextElement;
} List;

void print(List* list);
int isempty(List* list);
List* insert(List* list, int newValue);
List* delete(List* list, int deleteValue);
int findMTF(List* list, int searchedValue);
int findTRANS(List* list, int searchedValue);


#endif