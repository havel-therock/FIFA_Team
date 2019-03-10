#ifndef __LINKEDLIST_H_
#define __LINKEDLIST_H_

#include "../CheckStruct/checkStruct.h"

struct Node{
    struct Node* next;
    int value;
};

struct OneWayList{
    struct Node* head;
    struct Node* tail;
};

short isEmpty(struct OneWayList* list, struct CheckStruct* check);
void insert(struct OneWayList* list, int value, struct CheckStruct* check);
void deleteVal(struct OneWayList* list, int value, struct CheckStruct* check);
void findMTF(struct OneWayList* list, int value, struct CheckStruct* check);
void findTRANS(struct OneWayList* list, int value, struct CheckStruct* check);
void show (struct OneWayList* list, struct CheckStruct* check);

#endif