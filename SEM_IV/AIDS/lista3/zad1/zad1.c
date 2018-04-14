#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>
#include "sorts.h"
#include "global.h"

#include <linux/kernel.h>
#include <sys/sysinfo.h>

void printTable(int n, int table[]) {
	for(int i = 0; i < n; i++) {
		printf("%d ", table[i]);
	}
}

void isSorted(bool c, int table[], int n) {
	if(c) {
		for(int x = 0; x < n-1; x++) {
			if(table[x] > table[x+1]) {
			printf("Error sort\n");
			}
		}
	}
	else {
		for(int x = 0; x < n-1; x++) {
			if(table[x] < table[x+1]) {
			printf("Error sort\n");
			}
		}
	}
}

int main(int argc, char* argv[]) {
	double total;
	clock_t start_t, stop_t, total_t;
	int n, k, random;
	bool comp;
	FILE *fp;
	srand (time(NULL));
	int eny[] = {10,50,100,500,1000,5000,10000,50000,100000};
	
	if (argc == 5) {
		if((strcmp(argv[1], "--type")) == 0 && (strcmp(argv[3], "--comp")) == 0) {
			scanf("%d", &n);
			int table[n];
			
			if(n < 1) {
				return -1;
			}
			else if(n == 1) {
				scanf("%d", &table[0]);
				printTable(n, table);
				return 0;
			}
			else {
				for(int i = 0; i < n; i++) {
				scanf("%d", &table[i]);
				}
				if(strcmp(argv[2], "insert") == 0) {
					if(strcmp(argv[4], ">=") == 0) {
						comp = true;
						count = 0;
						swap = 0;
						start_t = clock();
						insertionSort(n, table, comp);
						stop_t = clock();
						total_t = stop_t - start_t;
						total = ((float)total_t/CLOCKS_PER_SEC);
						printf("Swaps: %d  |  Comparisons: %d  |  Time: %f\n", swap, count, total);
						isSorted(true, table, n);
						printTable(n, table);
					}
					else if(strcmp(argv[4], "<=") == 0) {
						comp = false;
						count = 0;
						swap = 0;	
						start_t = clock();					
						insertionSort(n, table, comp);
						stop_t = clock();
						total_t = stop_t - start_t;
						total = ((float)total_t/CLOCKS_PER_SEC);
						printf("Swaps: %d  |  Comparisons: %d  |  Time: %f\n", swap, count, total);
						isSorted(false, table, n);
						printTable(n, table);
					}
					else {
						printf("ERROR");
						return -1;
					}
				}
				else if(strcmp(argv[2], "merge") == 0) {
					if(strcmp(argv[4], ">=") == 0) {
						count = 0;
						swap = 0;
						start_t = clock();
						mergeSortI(table, 0, n-1);
						stop_t = clock();
						total_t = stop_t - start_t;
						total = ((float)total_t/CLOCKS_PER_SEC);
						printf("Swaps: %d  |  Comparisons: %d  |  Time: %f\n", swap, count, total);
						isSorted(true, table, n);
						printTable(n, table);
					}
					else if(strcmp(argv[4], "<=") == 0) {
						count = 0;
						swap = 0;
						start_t = clock();
						mergeSortD(table, 0, n-1);
						stop_t = clock();
						total_t = stop_t - start_t;
						total = ((float)total_t/CLOCKS_PER_SEC);
						printf("Swaps: %d  |  Comparisons: %d  |  Time: %f\n", swap, count, total);
						isSorted(false, table, n);
						printTable(n, table);
						
					}
					else {
						printf("ERROR");
						return -1;
					}
				}
				else if(strcmp(argv[2], "radix") == 0) {
					if(strcmp(argv[4], ">=") == 0) {
						count = 0;
						swap = 0;
						start_t = clock();
						n = sizeof(table)/sizeof(table[0]);					
						radixSortI(table, n);
						stop_t = clock();
						total_t = stop_t - start_t;
						total = ((float)total_t/CLOCKS_PER_SEC);
						printf("Swaps: %d  |  Comparisons: %d  |  Time: %f\n", swap, count, total);
						isSorted(true, table, n);
						printTable(n, table);
					}
					else if(strcmp(argv[4], "<=") == 0) {
						count = 0;
						swap = 0;
						start_t = clock();
						radixSortD(table, n);
						stop_t = clock();
						total_t = stop_t - start_t;
						total = ((float)total_t/CLOCKS_PER_SEC);
						printf("Swaps: %d  |  Comparisons: %d  |  Time: %f\n", swap, count, total);
						isSorted(false, table, n);
						printTable(n, table);
						
					}
					else {
						printf("ERROR");
						return -1;
					}
				}
				else if(strcmp(argv[2], "quick") == 0) {
					if(strcmp(argv[4], ">=") == 0) {
						count = 0;
						swap = 0;
						start_t = clock();
						quickSortI(table, 0, n-1);
						stop_t = clock();
						total_t = stop_t - start_t;
						total = ((float)total_t/CLOCKS_PER_SEC);
						printf("Swaps: %d  |  Comparisons: %d  |  Time: %f\n", swap, count, total);
						isSorted(true, table, n);
						printTable(n, table);
					}
					else if(strcmp(argv[4], "<=") == 0) {
						count = 0;
						swap = 0;
						start_t = clock();
						quickSortD(table, 0, n-1);
						stop_t = clock();
						total_t = stop_t - start_t;
						total = ((float)total_t/CLOCKS_PER_SEC);
						printf("Swaps: %d  |  Comparisons: %d  |  Time: %f\n", swap, count, total);
						isSorted(false, table, n);
						printTable(n, table);
					}
					else {
						printf("ERROR");
						return -1;
					}
				}
			}
		}
		
		// Conversion constants.
		const long minute = 60;
		const long hour = minute * 60;
		const long day = hour * 24;
		const double megabyte = 1024 * 1024;
		// Obtain system statistics.
		struct sysinfo si;
		sysinfo (&si);
		// Summarize interesting values.
		printf ("system uptime : %ld days, %ld:%02ld:%02ld\n", 
			si.uptime / day, (si.uptime % day) / hour, 
			(si.uptime % hour) / minute, si.uptime % minute);
		printf ("total RAM   : %5.1f MB\n", si.totalram / megabyte);
		printf ("free RAM   : %5.1f MB\n", si.freeram / megabyte);
		printf ("process count : %d\n", si.procs);
		
	}
	else {
		if((strcmp(argv[1], "--type")) == 0 && (strcmp(argv[3], "--comp")) == 0 && (strcmp(argv[5], "--stat")) == 0) {
			char filename[100];
			scanf("%d", &k);
			strcpy(filename, argv[6]);
			fp = fopen(filename, "w");
			for(int p = 0; p < 9; p++) {
				n = eny[p];
				int table[n];
				//fprintf(fp, "Size n = %d\n", n);
				for(int h = 0; h < k; h++) {
					for(int i = 0; i < n; i++) {
						random = rand() % 9999999;
						table[i] = random;
					}
					if(strcmp(argv[2], "insert") == 0) {
						if(strcmp(argv[4], ">=") == 0) {
							comp = true;
							count = 0;
							swap = 0;
							start_t = clock();
							insertionSort(n, table, comp);
							stop_t = clock();
							total_t = stop_t - start_t;
							total = ((float)total_t/CLOCKS_PER_SEC);
							fprintf(fp, "%d;%d;%f\n", swap, count, total);
							isSorted(true, table, n);
						}
						else if(strcmp(argv[4], "<=") == 0) {
							comp = false;
							count = 0;
							swap = 0;	
							start_t = clock();					
							insertionSort(n, table, comp);
							stop_t = clock();
							total_t = stop_t - start_t;
							total = ((float)total_t/CLOCKS_PER_SEC);
							fprintf(fp, "%d;%d;%f\n", swap, count, total);
							isSorted(false, table, n);
						}
						else {
							printf("ERROR");
							return -1;
						}
					}
					else if(strcmp(argv[2], "merge") == 0) {
						if(strcmp(argv[4], ">=") == 0) {
							count = 0;
							swap = 0;
							start_t = clock();
							mergeSortI(table, 0, n-1);
							stop_t = clock();
							total_t = stop_t - start_t;
							total = ((float)total_t/CLOCKS_PER_SEC);
							fprintf(fp, "%d;%d;%f\n", swap, count, total);
							isSorted(true, table, n);
						}
						else if(strcmp(argv[4], "<=") == 0) {
							count = 0;
							swap = 0;
							start_t = clock();
							mergeSortD(table, 0, n-1);
							stop_t = clock();
							total_t = stop_t - start_t;
							total = ((float)total_t/CLOCKS_PER_SEC);
							fprintf(fp, "%d;%d;%f\n", swap, count, total);
							isSorted(false, table, n);
							
						}
						else {
							printf("ERROR");
							return -1;
						}
					}
					
					else if(strcmp(argv[2], "quick") == 0) {
						if(strcmp(argv[4], ">=") == 0) {
							count = 0;
							swap = 0;
							start_t = clock();
							quickSortI(table, 0, n-1);
							stop_t = clock();
							total_t = stop_t - start_t;
							total = ((float)total_t/CLOCKS_PER_SEC);
							fprintf(fp, "%d;%d;%f\n", swap, count, total);
							isSorted(true, table, n);
						}
						else if(strcmp(argv[4], "<=") == 0) {
							count = 0;
							swap = 0;
							start_t = clock();
							quickSortD(table, 0, n-1);
							stop_t = clock();
							total_t = stop_t - start_t;
							total = ((float)total_t/CLOCKS_PER_SEC);
							fprintf(fp, "%d;%d;%f\n", swap, count, total);
							isSorted(false, table, n);
						}
						else {
							printf("ERROR");
							return -1;
						}
					}
					else if(strcmp(argv[2], "radix") == 0) {
						if(strcmp(argv[4], ">=") == 0) {
							count = 0;
							swap = 0;
							start_t = clock();
							radixSortI(table, n);
							stop_t = clock();
							total_t = stop_t - start_t;
							total = ((float)total_t/CLOCKS_PER_SEC);
							fprintf(fp, "%d;%d;%f\n", swap, count, total);
							isSorted(true, table, n);
						}
						else if(strcmp(argv[4], "<=") == 0) {
							count = 0;
							swap = 0;
							start_t = clock();
							radixSortD(table, n);
							stop_t = clock();
							total_t = stop_t - start_t;
							total = ((float)total_t/CLOCKS_PER_SEC);
							fprintf(fp, "%d;%d;%f\n", swap, count, total);
							isSorted(false, table, n);
						}
						else {
							printf("ERROR");
							return -1;
						}
					}
					else if(strcmp(argv[2], "dual") == 0) {
						if(strcmp(argv[4], ">=") == 0) {
							count = 0;
							swap = 0;
							start_t = clock();
							dualPivotSortI(table, 0, n-1);
							stop_t = clock();
							total_t = stop_t - start_t;
							total = ((float)total_t/CLOCKS_PER_SEC);
							fprintf(fp, "%d;%d;%f\n", swap, count, total);
							isSorted(true, table, n);
						}
						else if(strcmp(argv[4], "<=") == 0) {
							count = 0;
							swap = 0;
							start_t = clock();
							dualPivotSortD(table, 0, n-1);
							stop_t = clock();
							total_t = stop_t - start_t;
							total = ((float)total_t/CLOCKS_PER_SEC);
							fprintf(fp, "%d;%d;%f\n", swap, count, total);
							isSorted(false, table, n);
						}
						else {
							printf("ERROR");
							return -1;
						}
					}
				}
			}
			fclose(fp);
			/*
			// Conversion constants.
			const long minute = 60;
			const long hour = minute * 60;
			const long day = hour * 24;
			const double megabyte = 1024 * 1024;
			// Obtain system statistics.
			struct sysinfo si;
			sysinfo (&si);
			// Summarize interesting values.
			printf ("system uptime : %ld days, %ld:%02ld:%02ld\n", 
				si.uptime / day, (si.uptime % day) / hour, 
				(si.uptime % hour) / minute, si.uptime % minute);
			printf ("total RAM   : %5.1f MB\n", si.totalram / megabyte);
			printf ("free RAM   : %5.1f MB\n", si.freeram / megabyte);
			printf ("process count : %d\n", si.procs);
			*/
		}
	}
	return 0;
}