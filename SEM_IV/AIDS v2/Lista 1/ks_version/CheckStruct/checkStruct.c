#include "checkStruct.h"

#include <stdio.h>

int avgCom(struct CheckStruct* ch){
    if(ch->testRuns != 0)
        return (int) ch->countComparison/ch->testRuns;
    else{
        printf("TestRuns can't be zero\n");
        return -1;
    }
}


// add assignment counter maybe? later?
//future function which writes to files or something