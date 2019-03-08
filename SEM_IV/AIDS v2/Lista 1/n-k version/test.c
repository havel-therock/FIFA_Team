//
//  test.c
//  Lista1
//
//  Created by niebieski-kapturek on 04/03/2019.
//  Copyright © 2019 INF FIFA PPT TEAM. All rights reserved.
//

#include "lista.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int licznik_porownan;

int testMTF(List* list, unsigned int liczbaPermutacji, unsigned short int liczbaElementow, bool isCountedComparison, bool isCommented, bool isListVisible, unsigned int seed){
    licznik_porownan = 0;
    unsigned short int wektor_permutacji[liczbaElementow];
    srand(seed);
   
    for (unsigned short int i=0; i<liczbaElementow; i++){
        wektor_permutacji[i] = i + 1;
    }
        
    for (unsigned int j = liczbaPermutacji; j>0; j--){
        unsigned short int a, b, temp;
        a = rand()%liczbaElementow;
        b = rand()%liczbaElementow;
        temp = wektor_permutacji[a];
        wektor_permutacji[a] = wektor_permutacji[b];
        wektor_permutacji[b] = temp;
    }
    
    if(isListVisible){
        printf(" Lista jednokierunkowa:\n");
    
        for (unsigned short int i=0; i<liczbaElementow; i++){
            if (i%10 != 0)
                printf("%3d, ", wektor_permutacji[i]);
            else
                printf("\n%3d, ", wektor_permutacji[i]);
        }
    
        printf("\n\n");
    }
    
    for (unsigned short int i=0; i<liczbaElementow; i++){
        list = insert(wektor_permutacji[i], list, isCommented);
    }
    
    unsigned short int max = liczbaElementow;
    while (!(isempty(list))){
        for (unsigned short int i=1; i<=liczbaElementow; i++){
            findMTF(i, list, isCountedComparison, isCommented);
        }
        list = delete(max, list, isCountedComparison, isCommented);
        max--;
    }
    
    if(isCountedComparison) printf("MTF - liczba porównań = %d\n", licznik_porownan);
    return licznik_porownan;
}

int testTRANS(List* list, unsigned int liczbaPermutacji, unsigned short int liczbaElementow, bool isCountedComparison, bool isCommented, bool isListVisible, unsigned int seed){
    licznik_porownan = 0;
    unsigned short int wektor_permutacji[liczbaElementow];
    srand(seed);
    
    for (unsigned short int i=0; i<liczbaElementow; i++){
        wektor_permutacji[i] = i + 1;
    }
    
    for (unsigned int j = liczbaPermutacji; j>0; j--){
        unsigned short int a, b, temp;
        a = rand()%liczbaElementow;
        b = rand()%liczbaElementow;
        temp = wektor_permutacji[a];
        wektor_permutacji[a] = wektor_permutacji[b];
        wektor_permutacji[b] = temp;
    }
    
    if(isListVisible){
        printf(" Lista jednokierunkowa:\n");
        
        for (unsigned short int i=0; i<liczbaElementow; i++){
            if (i%10 != 0)
                printf("%3d, ", wektor_permutacji[i]);
            else
                printf("\n%3d, ", wektor_permutacji[i]);
        }
        
        printf("\n\n");
    }
    
    for (unsigned short int i=0; i<liczbaElementow; i++){
        list = insert(wektor_permutacji[i], list, isCommented);
    }
    
    unsigned short int max = liczbaElementow;
    while (!(isempty(list))){
        for (unsigned short int i=1; i<=liczbaElementow; i++){
            findTRANS(i, list, isCountedComparison, isCommented);
        }
        list = delete(max, list, isCountedComparison, isCommented);
        max--;
    }
    
    if(isCountedComparison) printf("TRANS - liczba porównań = %d\n", licznik_porownan);
    return licznik_porownan;
}

int testMTF2(List* list, unsigned int liczbaPermutacji, unsigned short int liczbaElementow, bool isCountedComparison, bool isCommented, bool isListVisible, unsigned int seed){
    licznik_porownan = 0;
    unsigned short int wektor_permutacji[liczbaElementow];
    srand(seed);
    
    for (unsigned short int i=0; i<liczbaElementow; i++){
        wektor_permutacji[i] = i + 1;
    }
    
    for (unsigned int j = liczbaPermutacji; j>0; j--){
        unsigned short int a, b, temp;
        a = rand()%liczbaElementow;
        b = rand()%liczbaElementow;
        temp = wektor_permutacji[a];
        wektor_permutacji[a] = wektor_permutacji[b];
        wektor_permutacji[b] = temp;
    }
    
    if(isListVisible){
        printf(" Lista jednokierunkowa:\n");
        
        for (unsigned short int i=0; i<liczbaElementow; i++){
            if (i%10 != 0)
                printf("%3d, ", wektor_permutacji[i]);
            else
                printf("\n%3d, ", wektor_permutacji[i]);
        }
        
        printf("\n\n");
    }
    
    for (unsigned short int i=0; i<liczbaElementow; i++){
        list = insert(wektor_permutacji[i], list, isCommented);
    }
    
    for (unsigned short int i=1; i<=liczbaElementow; i++){
        findMTF(i, list, isCountedComparison, isCommented);
    }
    
    unsigned short int max = liczbaElementow;
    while (!(isempty(list))){
        list = delete(max, list, isCountedComparison, isCommented);
        max--;
    }
    
    if(isCountedComparison) printf("MTF2 - liczba porównań = %d\n", licznik_porownan);
    return licznik_porownan;
}

int testTRANS2(List* list, unsigned int liczbaPermutacji, unsigned short int liczbaElementow, bool isCountedComparison, bool isCommented, bool isListVisible, unsigned int seed){
    licznik_porownan = 0;
    unsigned short int wektor_permutacji[liczbaElementow];
    srand(seed);
    
    for (unsigned short int i=0; i<liczbaElementow; i++){
        wektor_permutacji[i] = i + 1;
    }
    
    for (unsigned int j = liczbaPermutacji; j>0; j--){
        unsigned short int a, b, temp;
        a = rand()%liczbaElementow;
        b = rand()%liczbaElementow;
        temp = wektor_permutacji[a];
        wektor_permutacji[a] = wektor_permutacji[b];
        wektor_permutacji[b] = temp;
    }
    
    if(isListVisible){
        printf(" Lista jednokierunkowa:\n");
        
        for (unsigned short int i=0; i<liczbaElementow; i++){
            if (i%10 != 0)
                printf("%3d, ", wektor_permutacji[i]);
            else
                printf("\n%3d, ", wektor_permutacji[i]);
        }
        
        printf("\n\n");
    }
    
    for (unsigned short int i=0; i<liczbaElementow; i++){
        list = insert(wektor_permutacji[i], list, isCommented);
    }
    
    for (unsigned short int i=1; i<=liczbaElementow; i++){
        findTRANS(i, list, isCountedComparison, isCommented);
    }
    
    unsigned short int max = liczbaElementow;
    while (!(isempty(list))){
        list = delete(max, list, isCountedComparison, isCommented);
        max--;
    }
    
    if(isCountedComparison) printf("TRANS2 - liczba porównań = %d\n", licznik_porownan);
    return licznik_porownan;
}

int main(){
    List* list = NULL;
    int sumMTF=0, sumTRANS=0, sumMTF2=0, sumTRANS2=0, liczba_testow=10;
    for (int i = 0; i<liczba_testow; i++){
        printf("test %d: ", i); sumMTF += testMTF(list, 1234567, 100, true, false, false, i);
        printf("test %d: ", i); sumTRANS += testTRANS(list, 1234567, 100, true, false, false, i);
        printf("test %d: ", i); sumMTF2 += testMTF2(list, 1234567, 100, true, false, false, i);
        printf("test %d: ", i); sumTRANS2 += testTRANS2(list, 1234567, 100, true, false, false, i);
    }
    printf("\nŚrednia liczba porównań - wyniki testu:\nMetoda pierwsza:\nMTF = %d\nTRANS = %d\n", sumMTF/liczba_testow, sumTRANS/liczba_testow);
    if (sumTRANS > sumMTF) printf("MTF lepszy niż TRANS\n");
    else if (sumTRANS == sumMTF) printf("MTF i TRANS są tak samo dobre\n");
    else printf("TRANS lepszy niż MTF\n\n");
    printf("\nMetoda druga:\nMTF2 = %d\nTRANS2 = %d\n", sumMTF2/liczba_testow, sumTRANS2/liczba_testow);
    if (sumTRANS > sumMTF) printf("MTF lepszy niż TRANS\n");
    else if (sumTRANS == sumMTF) printf("MTF i TRANS są tak samo dobre\n");
    else printf("TRANS lepszy niż MTF\n\n");
    return 0;
}
