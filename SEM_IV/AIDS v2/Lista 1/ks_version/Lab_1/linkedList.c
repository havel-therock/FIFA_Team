#include <stdio.h>
#include <stdlib.h>
#include "linkedList.h"
#include "../CheckStruct/checkStruct.h"

short isEmpty(struct OneWayList* list, struct CheckStruct* check){
    // !!!! COMPARISON 
    check->countComparison++;
    if(list->head == NULL){
        return 1;   // true when list is empty
    }else{
        return 0;   // false when list is not empty
    }
}

void insert(struct OneWayList* list, int val, struct CheckStruct* check){
    // first insertion, head init
    if(isEmpty(list, check)){
        list->head = malloc(sizeof(struct Node));   // allocate memory for new node
        list->head->value = val;    
        list->head->next = NULL;
        list->tail = list->head;    // head and tail are the same now   
    }// insertion when list contains some elements previously
    else{
        list->tail->next = malloc(sizeof(struct Node));   // allocate memory for new node
        list->tail = list->tail->next;   // point tail to a new location
        list->tail->value = val;
    } 
}

void deleteVal(struct OneWayList* list, int val, struct CheckStruct* check){
    //check if there is anything to delete in the list
    if(isEmpty(list, check)){
        printf("There is nothing to delete.\n");
    }else{
        short findFlag = 0;
        struct Node* iterator = list->head;
        //  !!!! COMPARISON
        check->countComparison++;
        //  check if head has seeking value
        if(iterator->value == val){
            findFlag = 1;
            //  !!!! COMPARISON
            check->countComparison++;
            //  check if head == tail (only one element in list)
            if(list->head == list->tail){
                list->head = NULL;
                list->tail = NULL;
                free(iterator);
                iterator = NULL;
            }else{  //  seeking value in head, but there are at least two elements
                list->head = iterator->next;
                free(iterator);
                iterator = NULL;
            }
        }else{
            while(iterator->next != NULL){
            // !!!! COMPARISON
            check->countComparison++; 
            // check /\/\/\ if we reach end of list
                // !!!! COMPARISON 
                check->countComparison++;
                // check if we find desirable value
                if(iterator->next->value == val){
                    findFlag = 1;
                    // !!!! COMPARISON
                    check->countComparison++; 
                    // check if we find desirable value at the end of list
                    if(iterator->next->next == NULL){
                        list->tail = iterator;
                        free(iterator->next);
                        iterator->next = NULL;
                        iterator = NULL;
                        break;
                    }else{
                        struct Node* tmp = iterator->next->next;
                        free(iterator->next);
                        iterator->next = tmp;
                        tmp = NULL;
                        iterator = NULL;
                        break;
                    }
                }else{
                    iterator = iterator->next;
                    //we move one step forward
                }
            }
            // Comparison but not included in statistics beacuse only for printf purpouse
            if(!findFlag){
               printf("List does not contain %i.\n", val);
            } 
        }
    }
}

void findMTF(struct OneWayList* list, int val, struct CheckStruct* check){
    //check if there is anything to seek in the list
    if(isEmpty(list, check)){
        printf("There is nothing to delete.\n");
    }else{
        struct Node* iterator = list->head;
        //  !!!! COMPARISON
        check->countComparison++;
        //  check if head has seeking value
        if(iterator->value == val){
          //  printf("find in the head\n");
        }else{
            short findFlag = 0;
            while(iterator->next != NULL){
            // !!!! COMPARISON 
            check->countComparison++;
            // check /\/\/\ if we reach end of list
                // !!!! COMPARISON 
                check->countComparison++;
                // check if we find desirable value
                if(iterator->next->value == val){
                    findFlag = 1;
                    // !!!! COMPARISON 
                    check->countComparison++;
                    // check if we find desirable value at the end of list
                    if(iterator->next->next == NULL){
                        iterator->next->next = list->head;
                        list->head = iterator->next;
                        list->tail = iterator;
                        list->tail->next = NULL;
                        break;
                    }else{
                        struct Node* tmp = iterator->next->next;
                        iterator->next->next = list->head;
                        list->head = iterator->next;
                        iterator->next = tmp;
                        tmp = NULL;
                        break;
                    }
                }else{
                    iterator = iterator->next;
                    //we move one step forward
                }
            }
            // Comparison but not included in statistics beacuse only for printf purpouse
            if(!findFlag){
               printf("List does not contain %i.\n", val);
            } 
        }
    }

}

void findTRANS(struct OneWayList* list, int val, struct CheckStruct* check){
    //check if there is anything to seek in the list
    if(isEmpty(list, check)){
        printf("There is nothing to delete.\n");
    }else{
        struct Node* iterator = list->head;
        //  !!!! COMPARISON
        check->countComparison++;
        //  check if head has seeking value
        if(iterator->value == val){
           // printf("find in the head\n");
        }else{
            short findFlag = 0;
            // case next to head
            //!!COMPARISON
            check->countComparison++;
            
            if(iterator->next == NULL){
             //   printf("there is no %i in the list", val);
            }else{ 
                //!!COMPARISON
                check->countComparison++;
                if(iterator->next->value == val){
                    findFlag = 1;
                    //detects if only two elements in the list
                    check->countComparison++;
                    // !!!!! COMPARISON
                    if(iterator->next == list->tail){
                        iterator->next = NULL;
                        list->tail->next = list->head;
                        list->head = list->tail;
                        list->tail = list->tail->next;
                        iterator = NULL;
                    }else{
                        list->head = iterator->next;
                        iterator->next = iterator->next->next;
                        list->head->next = iterator;
                        iterator = NULL; 
                    }
                }else{
                    //// !!!! COMPARISON 
                    check->countComparison++;
                    //if list larger than two
                    if(iterator->next->next != NULL){
                        struct Node* prev = iterator;
                        iterator = iterator->next;  
                        while(iterator->next != NULL){
                        //firsto comparison dumb should. It was checked in upper if. should use do while instead of while
                        // !!!! COMPARISON 
                        check->countComparison++;
                        // check /\/\/\ if we reach end of list
                            // !!!! COMPARISON 
                            check->countComparison++;
                            // check if we found desirable value
                            if(iterator->next->value == val){
                                findFlag = 1;
                                // !!!! COMPARISON 
                                check->countComparison++;
                                // check if we found desirable value at the end (tail)
                                if(iterator->next == list->tail){
                                    iterator->next->next = iterator;
                                    iterator->next = NULL;
                                    prev->next = list->tail;
                                    list->tail = iterator;
                                    iterator = NULL;
                                    prev = NULL;
                                    break;
                                }else{ // or in the middle
                                    prev->next = iterator->next;
                                    iterator->next = iterator->next->next;
                                    prev->next->next = iterator;
                                    iterator = NULL;
                                    prev = NULL;
                                    break;
                               }   
                            }else{
                                prev = prev->next;
                                iterator = iterator->next;
                                //we move one step forward
                            }
                        }
                    } 
                }
            }
            // Comparison but not included in statistics beacuse only for printf purpouse
            if(!findFlag){
               printf("List does not contain %i.\n", val);
            } 
        }
    }
}


void show (struct OneWayList* list, struct CheckStruct* check){
    if(isEmpty(list, check)){
        printf("Empty List. Nothing to display.\n");
    }else{
        struct Node* curr = list->head;
        while(curr->next != NULL){
            printf("%i ", curr->value);
            curr = curr->next;
        }
        printf("%i\n", curr->value);
        curr = NULL;
    } 
}
