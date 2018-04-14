all: zad1.o insertionSort.o mergeSort.o quickSort.o dualPivotSort.o radixSort.o
	gcc zad1.o insertionSort.o mergeSort.o quickSort.o dualPivotSort.o radixSort.o -o main

zad1.o: zad1.c insertionSort.c mergeSort.c quickSort.c dualPivotSort.c radixSort.c sorts.h global.h
	gcc zad1.c -c -o zad1.o

insertionSort.o: insertionSort.c global.h sorts.h
	gcc insertionSort.c -c -o insertionSort.o

mergeSort.o: mergeSort.c global.h sorts.h
	gcc mergeSort.c -c -o mergeSort.o

radixSort.o: radixSort.c global.h sorts.h
	gcc radixSort.c -c -o radixSort.o

quickSort.o: quickSort.c global.h sorts.h
	gcc quickSort.c -c -o quickSort.o

dualPivotSort.o: dualPivotSort.c global.h sorts.h
	gcc dualPivotSort.c -c -o dualPivotSort.o

clear:
	rm -f *.o main
