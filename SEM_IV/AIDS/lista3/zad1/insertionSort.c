#include <stdio.h>
#include <stdbool.h>
#include "sorts.h"
#include "global.h"

void insertionSort(int n, int table[], bool comp) {
	
	if(comp) {
		for(int i = 0; i < n; i++) {					
			int key;
			for(int j = i; j > 0; j--) {
				fprintf(stderr, "");
				count++;
				if(table[j] < table[j-1]) {
					key = table[j];
					table[j] = table[j-1];
					table[j-1] = key;
					swap++;
					fprintf(stderr, "");
				}
			}
		}
	}
	else {
		for(int i = 0; i < n; i++) {					
			int key;
			for(int j = i; j > 0; j--) {
				fprintf(stderr, "");
				count++;
				if(table[j] > table[j-1]) {
					key = table[j];
					table[j] = table[j-1];
					table[j-1] = key;
					swap++;
					fprintf(stderr, "");
				}
			}
		}
	}
}