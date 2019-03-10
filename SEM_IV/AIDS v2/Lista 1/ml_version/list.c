#include "list.h"
#include <stdio.h>
#include <stdlib.h>

// Funcka ismepty - funkcja sprawdzająca czy struktura ma elementy, czyli różna od NULL
// list - struktura
int isempty(List* element) {
    if(element == NULL) {
        return 1;
    }
    else {
        return 0;
    }
}

// Funkcja insert - funkcja dodająca nowy elemenet do struktury
// list - struktura
// newValue - nowa wartość, która ma zostać wprowadzona do struktury
List* insert(List* list, int newValue) {
    List* insertedElement = malloc(sizeof(*insertedElement));
    insertedElement -> value = newValue;
    insertedElement -> nextElement = NULL;

    if(isempty(list)) {
        list = insertedElement;
        list -> value = insertedElement -> value;
        list -> nextElement = insertedElement -> nextElement;
    }
    else {
        List* tempList = malloc(sizeof(*list));
        tempList = list;
        while((tempList -> nextElement) != NULL) {
            tempList = tempList -> nextElement;
        }
        tempList -> nextElement = insertedElement;
    }
    
    return list;
}

// Funcka delete - funcka usuwająca element ze struktury
// list - struktura
// deleteValue - wartość, która ma zostać usunięta ze struktury
List* delete(List* list, int deleteValue) {
    if(isempty(list)) {
        printf("\nLIST IS EMPTY\n\n");
        numberOfComparisons++;
        return list;
    }
    else if(list -> value == deleteValue) {
        if(isempty(list -> nextElement)) {
            list = NULL;
        }
        else {
            list -> value = list -> nextElement -> value;
            list -> nextElement = list -> nextElement -> nextElement;
        }
        numberOfComparisons++;
        return list;
    }
    else if(isempty(list -> nextElement)) {
        numberOfComparisons++;
        printf("\nNO ITEM IN LIST\n\n");
        return list;
    }
    else if(list -> nextElement -> value == deleteValue) {
        list -> nextElement = list -> nextElement -> nextElement;
        numberOfComparisons++;
        return list;
    }
    else {
        numberOfComparisons++;
        delete(list -> nextElement, deleteValue);
    }
}

// Funkcja findMTF - funkcja sprawdzająca czy argument znajduje się w strukturze,
//                   w przypadku znalezienia przesuwa element na pierwszą pozycję w strukturze
// list - struktura
// searchedValue - szukana wartość w strukturze
int findMTF(List* list, int searchedValue) {
    int exist = 0;

    if(isempty(list)) {
        printf("\nLIST IS EMPTY\n\n");
        numberOfComparisons++;
        return 0;
    }
    else if(list -> value == searchedValue) {
        printf("\nITEM IS ON FIRST POSITION\n\n");
        numberOfComparisons++;
        return 1;
    }
    else {
        List* tempList = list;
        while(tempList -> nextElement != NULL) {
            if(tempList -> nextElement -> value != searchedValue) {
                numberOfComparisons++;
                tempList = tempList -> nextElement;
            }
            else {
                tempList -> nextElement = tempList -> nextElement -> nextElement;
                numberOfComparisons++;
                exist = 1;
                break;
            }
        }
    }

    if(exist) {
        List* insertedElement = malloc(sizeof(*insertedElement));
        insertedElement -> nextElement = list -> nextElement;
        int temp = list -> value;
        list -> nextElement = insertedElement;
        insertedElement -> value = temp;
        list -> value = searchedValue;
    }
    else {
        printf("\nNO ITEM IN LIST %i\n\n", searchedValue);
        numberOfComparisons++;
    }

    return exist;
}

// Funkcja findTRANS - funkcja sprawdzająca czy argument znajduje się w strukturze, 
//                     w przypadku znalezienia przesuwa o jedno miejsce do przodu struktury
// list - struktura
// searchedValue - wartość szukana w strukturze
int findTRANS(List* list, int searchedValue) {
    int exist = 0;

    if(isempty(list)) {
        printf("\nLIST IS EMPTY\n\n");
        numberOfComparisons++;
        return 0;
    }
    else if(list -> value == searchedValue) {
        printf("\nITEM IS ON FIRST POSITION\n\n");
        list = list -> nextElement;
        numberOfComparisons++;
        return 1;
    }
    else {
        List* tempList = list;
        while(tempList -> nextElement != NULL) {
            if(tempList -> nextElement -> value != searchedValue) {
                numberOfComparisons++;
                tempList = tempList -> nextElement;
            }
            else {
                int temp = tempList -> value;
                tempList -> value = searchedValue;
                tempList -> nextElement -> value = temp; 
                numberOfComparisons++;
                exist = 1;
                // break;
            }
        }
    }

    if(exist) {
        numberOfComparisons++;
        return exist;
    }
    else {
        printf("\nNO ITEM IN LIST %i\n\n", searchedValue);
        numberOfComparisons++;
        return exist;
    }
}

// Funkcja print - funckja wypisująca wszystkie wartości w strukturze
// list - struktura
void print(List* list) {
    if(isempty(list)) printf("LIST IS EMPTY");
    while(list != NULL) {
        printf("%d, ", list -> value);
        list = list -> nextElement;
    }
    printf("\n");
}