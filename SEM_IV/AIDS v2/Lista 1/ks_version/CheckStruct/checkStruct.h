#ifndef __CHECKSTRUCT_H_
#define __CHECKSTRUCT_H_

//  You need proper init with this structure 
//  countComp for ex. should be 0 at start for most cases

struct CheckStruct{
    int countComparison;
    int testRuns;
    int currMaxValue;
};

int avgCom(struct CheckStruct* ch);

#endif