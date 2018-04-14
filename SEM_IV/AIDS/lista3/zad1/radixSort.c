#include <stdio.h>
#include <stdlib.h>
#include "global.h"

int getMax(int array[], int n) {
	int max = array[0];
	
	for(int i = 1; i < n; i++) {
		count++;
		if(array[i] > max) {
			max = array[i];
		}
	}
	return max;
}

void countSortI(int array[], int n, int e) {
	int table[n];
	int i;
	int C[10] = {0};
	
	for(i = 0; i < n; i++) {
		C[(array[i]/e)%10]++;
	}
	
	for(i = 1; i < 10; i++) {
		C[i] += C[i-1];
	}
	
	for(i = n-1; i >= 0; i--) {
		table[C[(array[i]/e)%10]-1] = array[i];
		C[(array[i]/e)%10]--;
	}
	
	for(i =0; i < n; i++) {
		array[i] = table[i];
	}
}

void countSortD(int array[], int n, int e) {
	int table[n];
	int i;
	int C[10] = {0};
	
	for(i = 0; i < n; i++) {
		C[(array[i]/e)%10]++;
	}
	
	for(i = 1; i < 10; i++) {
		C[i] += C[i-1];
	}
	
	for(i = 0; i < n; i++) {
		table[n-C[(array[i]/e)%10]] = array[i];
		C[(array[i]/e)%10]--;
	}
	
	for(i =0; i < n; i++) {
		array[i] = table[i];
	}
}

void radixSortI(int array[], int n) {
	int max = getMax(array, n);
	
	for(int e = 1; max/e; e *= 10) {			// e is 10^i, i is current digit number
		countSortI(array, n, e);
	}
}

void radixSortD(int array[], int n) {
	int max = getMax(array, n);
	
	for(int e = 1; max/e; e *= 10) {			// e is 10^i, i is current digit number
		countSortD(array, n, e);
	}
}