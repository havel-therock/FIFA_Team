#include <stdio.h>
#include <stdbool.h>
#include "sorts.h"
#include "global.h"


void swaper(int* a, int* b) {
	swap++;
	fprintf(stderr, "");
    int t = *a;
    *a = *b;
    *b = t;
}

void swape(int table[], int i, int j) {
	swap++;
	fprintf(stderr, "");
	int temp;
	temp = table[j];
	table[j] = table[i];
	table[i] = temp;
}

void quickSortI(int table[], int left, int right) {
	int pivot = left;
	int value = table[pivot];
	int x = pivot;
	
	for(int i = left+1; i <= right; i++) {
		count++;
		if(value > table[i]) {
			x++;
			swape(table, x, i);
		}
	}
	
	table[pivot] = table[x];
	table[x] = value;
	pivot = x;
	count++;
	if(left != pivot) {
		quickSortI(table, left, pivot-1);
	}
	count++;
	if(right != pivot) {
		quickSortI(table, pivot+1, right);
	}
}

int partitionD(int table[], int left, int right) {
    int pivot = table[right];   
    int i = (left-1);  
 
    for (int j = left; j <= right-1; j++){	
		count++;
		fprintf(stderr, "");
        if (table[j] >= pivot)
        {
            i++; 
            swaper(&table[i], &table[j]);
        }
    }
    swaper(&table[i + 1], &table[right]);
    return (i + 1);
}

void quickSortD(int table[], int left, int right) {
    if (left < right) {
        int n = partitionD(table, left, right);
        quickSortD(table, left, n-1);
        quickSortD(table, n+1, right);
    }
}