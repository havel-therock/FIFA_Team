#include "list.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

List* init(List* list) {
    for(int i = 1; i <= 100; i++) {
        list = insert(list, i);
    }
    return list;
}

List* initRandom(List* list) {
    int interval = 100;
    int tab[100];
    int iterator, guard;

    for(int i = 0; i < 100; i++) {
        tab[i] = i + 1;
    }

    for(int i = 0; i < 100; i++) {
        srand(time(NULL));
        guard = rand() % interval;
        iterator = 0;
        for(int j = 0; j < 100; j++) {
            if(tab[j] != 0) {                
                if(iterator == guard) {
                list = insert(list, tab[j]);
                tab[j] = 0;
                interval--;
                break;
                }
                else {
                    iterator++;
                }
            }
        }
    }

    return list;
}

List* deleteTestFinders(List* list, int function) {
    List* tempList = list;
    for(int i = 100; i >= 1; i--) {
        for(int j = 1; j <= 100; j++) {
            if(function) {
                findTRANS(tempList, j);
            }
            else {
                findMTF(tempList, j);
            }
        }
        print(list);
        tempList = delete(list, i);
    }
    list = tempList;
    return list;
}