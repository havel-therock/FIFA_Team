#include "../CheckStruct/checkStruct.h"
#include "linkedList.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void init(struct OneWayList* l, struct CheckStruct* ch){

    int interval = 100, iterator, guard;
    
    int tab[100];
    for(int i = 0; i < 100; i++){
        tab[i] = i+1;
    }

    for(int i = 0; i < 100; i++){
        guard = rand() % interval;
        iterator = 0;
        for(int j = 0; j < 100; j++){
            if(tab[j] != 0){                
                if(iterator == guard){
                insert(l, tab[j], ch);
                tab[j] = 0;
                interval--;
                break;
                }else{
                    iterator++;
                }
            }
        }
    }

}

int main(int argc, char const *argv[])
{   
    struct CheckStruct* ch = malloc(sizeof(struct CheckStruct));
    ch->countComparison = 0;
    ch->testRuns = 100;
    struct OneWayList* l = malloc(sizeof(struct OneWayList));
    srand(time(NULL));


    ch->countComparison = 0;
    for(int i = 0; i < 100; i++){
        ch->currMaxValue = 100;
        //ch->countComparison = 0;
        init(l, ch);
        ch->countComparison = ch->countComparison - 100;
        for(int i = 0; i < 100; i++){
            for(int j = 1; j <= /*100*/ch->currMaxValue; j++){
               findMTF(l, j, ch);
            }
            // show(l, ch);
            //printf("%i!\n", ch->currMaxValue);
            deleteVal(l, ch->currMaxValue, ch);
            ch->currMaxValue--;
        }
    }
    
    int a = ch->countComparison, b = avgCom(ch);

    ch->countComparison = 0;
    for(int i = 0; i < 100; i++){
        ch->currMaxValue = 100;
        //ch->countComparison = 0;
        ch->countComparison = ch->countComparison - 100;
        init(l, ch);
        for(int i = 0; i < 100; i++){
            for(int j = 1; j <= /*100*/ch->currMaxValue; j++){
               findTRANS(l, j, ch);
            }
            // show(l, ch);
            //printf("%i!\n", ch->currMaxValue);
            deleteVal(l, ch->currMaxValue, ch);
            ch->currMaxValue--;
        }
    }
    
    printf("Wszystkie porównania MTF %i\n Średnio%i\n",a, b);
    printf("Wszystkie porównania TRANS %i\n Średnio%i\n",ch->countComparison, avgCom(ch));
    return 0;
}
