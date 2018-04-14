#include <stdio.h>
#include <stdlib.h>
#include "global.h"
#include "function.h"

void swap(int array[], int i, int j) {
	int temp;
	temp = array[j];
	array[j] = array[i];
	array[i] = temp;
}

void insertionSort(int *array, int start, int end) {
    for (int i = start + 1; i < end + 1; i++) {
        for (int j = i - 1; j >= start; j--) {
            if (array[j] > array[j + 1]) {
                swap(array, j, j + 1);
            } else break;
        }
    }
}