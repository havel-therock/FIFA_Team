#ifndef test_h
#define test_h

#include "list.h"
#include <stdio.h>
#include <stdlib.h>

List* init(List* list);
List* initRandom(List* list);
List* deleteTestFinders(List* list, int function);

#endif