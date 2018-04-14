#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "global.h"

void printTable(int n, int table[]) {
	for(int i = 0; i < n; i++) {
		printf("%d ", table[i]);
	}
	printf("\n");
}

void swap(int table[], int i, int j) {
	int temp;
	temp = table[j];
	table[j] = table[i];
	table[i] = temp;
}

void quickSort(int table[], int left, int right) {
	int pivot = left;
	int value = table[pivot];
	int x = pivot;
	
	for(int i = left+1; i <= right; i++) {
		if(value > table[i]) {
			x++;
			swap(table, x, i);
		}
	}
	
	table[pivot] = table[x];
	table[x] = value;
	pivot = x;
	
	if(left != pivot) {
		quickSort(table, left, pivot-1);
	}
	if(right != pivot) {
		quickSort(table, pivot+1, right);
	}
}

int binarySearch(int table[], int left, int right, int value) {
	int mid = left+(right-left+1)/2;
	compares++;
	compares++;
	if(mid < 0 || mid > right) {
		return 0;
	}
	compares++;
	if(table[mid] == value) {
		return 1;
	}
	compares++;
	if(left == right) {
		return 0;
	}
	compares++;
	if(table[mid] < value) {
		return binarySearch(table, mid+1, right, value);
	}
	else {
		return binarySearch(table, left, mid-1, value);
	}
}

int main(int argc, char* argv[]) {
	int n = strtol(argv[1], NULL, 10);
	int search = strtol(argv[2], NULL, 10);
	int table[n];
	int result;
	srand (time(NULL));
	
	for(int i = 0; i < n; i++) {
		table[i] = rand() % 10000 + 1;
	}
	compares = 0;
	quickSort(table, 0, n-1);
	printTable(n, table);
	result = binarySearch(table, 0, n-1, search);
	printf("%d", result);
	printf("\n%d", compares);
}