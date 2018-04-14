all: zad2.o insertionSort.o
	gcc zad1.o insertionSort.o -o main

zad1.o: zad1.c insertionSort.c function.h global.h
	gcc zad1.c -c -o zad1.o

insertionSort.o: insertionSort.c global.h function.h
	gcc insertionSort.c -c -o insertionSort.o

clear:
	rm -f *.o main
