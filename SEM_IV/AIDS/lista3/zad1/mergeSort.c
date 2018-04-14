#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>
#include "sorts.h"
#include "global.h"

void mergeI(int table[], int left, int mid, int right)
{
    int i, j, k;
    int n1 = mid-left+1;
    int n2 = right-mid;
 
    int L[n1], R[n2];
 
    for (i = 0; i < n1; i++)
        L[i] = table[left + i];
    for (j = 0; j < n2; j++)
        R[j] = table[mid+1+j];
 
    i = 0; 
    j = 0; 
    k = left; 
    while (i < n1 && j < n2) {	
		fprintf(stderr, "");
		count++;
        if (L[i] <= R[j]) {
			swap++;
            table[k] = L[i];
            i++;
        }
        else {
			swap++;
            table[k] = R[j];
            j++;
        }
        k++;
    }
	
    while (i < n1) {
		swap++;
        table[k] = L[i];
        i++;
        k++;
    }
    while (j < n2) {
		swap++;
        table[k] = R[j];
        j++;
        k++;
    }
}
 
void mergeSortI(int table[], int left, int right) {
	count++;
    if (left < right) {
        int mid = left+(right-left)/2;
 
        mergeSortI(table, left, mid);
        mergeSortI(table, mid+1, right);
 
        mergeI(table, left, mid, right);
    }
}

void mergeD(int table[], int left, int mid, int right)
{
    int i, j, k;
    int n1 = mid-left+1;
    int n2 = right-mid;
 
    int L[n1], R[n2];
 
    for (i = 0; i < n1; i++)
        L[i] = table[left + i];
    for (j = 0; j < n2; j++)
        R[j] = table[mid+1+j];
 
    i = 0; 
    j = 0; 
    k = left; 
    while (i < n1 && j < n2) {	
		fprintf(stderr, "");
		count++;
        if (L[i] >= R[j]) {
			swap++;
            table[k] = L[i];
            i++;
        }
        else {
			swap++;
            table[k] = R[j];
            j++;
        }
        k++;
    }
	
    while (i < n1) {
		swap++;
        table[k] = L[i];
        i++;
        k++;
    }
    while (j < n2) {
		swap++;
        table[k] = R[j];
        j++;
        k++;
    }
}
 
void mergeSortD(int table[], int left, int right) {
	count++;
    if (left < right) {
        int mid = left+(right-left)/2;
 
        mergeSortI(table, left, mid);
        mergeSortI(table, mid+1, right);
 
        mergeI(table, left, mid, right);
    }
}
