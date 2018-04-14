#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "global.h"
#include "function.h"

void printTable(int n, int table[]) {
	for(int i = 0; i < n; i++) {
		printf("%d ", table[i]);
	}
}

int medianDistance(int number) {
    if(number == 1 || number == 2) {
		return 0;
	}
    else if(number == 3 || number == 4) {
		return 1;
	}
    else return 2;
}

void selectPivot(int *array, int start, int end) {
	int arraySize = end-start+1;
	int nrGroup;
	nrGroup = ((arraySize % 5) ? arraySize/5+1 : arraySize/5);
	
	while(arraySize > 5) {
		int sizeLast = (arraySize % 5) ? arraySize % 5 : 5;
		for(int i = 0; i < nrGroup - 1; i++) {
			insertionSort(array, (i*5)+start, ((i+1)*5-1)+start);
		}
		//Last group:
		insertionSort(array, ((nrGroup-1)*5)+start, ((nrGroup)*5-1-(5-sizeLast))+start);
		
		for(int i = 0; i < nrGroup-1; i++) {
			swap(array, i+start, (5*i+2)+start);
		}
		//Last group:
		swap(array, (nrGroup-1)+start, (5*(nrGroup-1)+medianDistance(sizeLast))+start);
		arraySize = nrGroup;
		nrGroup = ((arraySize % 5) ? arraySize/5+1 : arraySize/5);
	}
	insertionSort(array, 0+start, (arraySize-1)+start);
	swap(array, 0+start, (medianDistance(arraySize))+start);
}

int selectPartition(int *array, int start, int end) {
	if(start == end) return start;
	printf("problem1");
	selectPivot(array, start, end);
	printf("problem1.1");
	int pivot = (end - start + 1);
	printf("problem2");
	int pivotValue = array[pivot];
	swap(array, pivot, end);
	printf("problem3");
	int lessIndex = start;
	for(int y = start; y < end; y++) {
		if(array[y] <= pivotValue) {
			swap(array, lessIndex, y);
			lessIndex++;
		}
	}
	swap(array, lessIndex, end);
	return lessIndex;
}

int selectRecursion(int *array, int start, int end, int k) {
	fprintf(stderr, "Recursion for %d - %d\n", start, end);
	int pivot = selectPartition(array, start, end);
	fprintf(stderr, "Pivot -> %d\n", pivot);
	if(pivot == k) {
		fprintf(stderr, "Pivot equals k\n");
		int x = array[k];
		printf("%d", x);
		return x;
	}
	else if(pivot < k) {
		fprintf(stderr, "Pivot < k\n");
		return selectRecursion(array, pivot+1, end, k);
	}
	else {
		fprintf(stderr, "Pivot > k\n");
		return selectRecursion(array, start, pivot-1, k);
	}
}

int select(int *array, int k) {
	int *arrayC = malloc(lenght * sizeof(int));
	int result = selectRecursion(arrayC, 0, lenght-1, k);
	free(arrayC);
	printf("prawie");
	return result;
}

int partition(int a[], int p, int r) {
    int x = a[r];
    int i = p-1;
    for(int j = p; j < r; j++){
		comp++;
		//fprintf(stderr, "Compare %d <= %d?\n", a[j], a[x]);
        if(a[j] <= x){
            i++;
			swapp++;
			fprintf(stderr, "Swap %d with %d\n", a[i], a[j]);
            swap(a, i, j);
        }
    }
	swapp++;
	fprintf(stderr, "Swap %d with %d\n", a[i+1], a[r]);
    swap(a, i+1, r);
    return i+1;
}


int randomizedPartition(int a[], int p, int r) {
    int i = rand() % r + 1; //flag for debugging
	swapp++;
	fprintf(stderr, "Swap %d with %d\n", a[i], a[r]);
    swap(a, i, r);
    return partition(a, p, r);
}


int randomizedSelect(int a[], int p, int r, int i) {	
	comp++;
    if(p==r)
        return a[p];
    int q = randomizedPartition(a,p,r);
    int k = q-p+1;
	comp++;
    if(i == k) {
		fprintf(stderr, "Compare %d == %d?\n", a[i], a[k]);
        return a[q];
	}
    else if(i < k) {
		fprintf(stderr, "Compare %d < %d?\n", a[i], a[k]);
		comp++;
        return randomizedSelect(a, p, q-1, i);
	}
    else {
		fprintf(stderr, "Compare %d > %d?\n", a[i], a[k]);
		return randomizedSelect(a, q+1, r, i-k);
	}
}


void mix(int table[], int n) {
	int r;
	for(int i = n-1; i > 0; i--) {
		r = rand()%i;
		swap(table, r, i);
	}
}

int main(int argc, char* argv[]) {
	int n, k, result;
	srand(time(NULL));
	comp = 0;
	swapp = 0;
	if(argc == 2) {
		if((strcmp(argv[1], "-p")) == 0) {
			scanf("%d", &n);
			int table[n];
			lenght = n;
			//fprintf(stderr, "P\n");
			scanf("%d", &k);
			if(k < 1 || k > n) {
				fprintf(stderr, "ERROR");
				return 0;
			}
			for(int i = 0; i < n; i++){
				table[i] = i+1;
			}
			//printTable(n, table);
			mix(table, n);
			//fprintf(stderr, "\nmix table\n");
			printTable(n, table);
			fprintf(stderr, "\n");
			result = randomizedSelect(table, 0, n-1, k);
			//result = select(table, n);
			for(int i = 0; i < n; i++) {
				if(table[i] != result) {
					fprintf(stderr, "%d ", table[i]);
				}
				else {
					fprintf(stderr, "[%d] ", table[i]);
				}
			}
		}
		else if((strcmp(argv[1], "-r")) == 0) {
			scanf("%d", &n);
			int table[n];
			lenght = n;
			//fprintf(stderr, "R\n");
			scanf("%d", &k);
			if((k < 1) || (k > n)) {
				fprintf(stderr, "ERROR");
				return 0;
			}
			for(int i = 0; i < n; i++) {
				table[i] = rand()%1000;
			}
			printTable(n, table);
			fprintf(stderr, "\n");
			mix(table, n); 
			result = randomizedSelect(table, 0, n-1, k);
			//result = select(table, n);
			for(int i = 0; i < n; i++) {
				if(table[i] != result) {
					fprintf(stderr, "%d ", table[i]);
				}
				else {
					fprintf(stderr, "[%d] ", table[i]);
				}
			}
		}
	}
	else {
		return 0;
	}
}

