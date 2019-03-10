output: linkedList.o checkStruct.o main.o
	gcc linkedList.o checkStruct.o main.o -o output 

linkedList.o: linkedList.c linkedList.h ../CheckStruct/checkStruct.h
	gcc -c linkedList.c

checkStruct.o: ../CheckStruct/checkStruct.c ../CheckStruct/checkStruct.h
	gcc -c ../CheckStruct/checkStruct.c

main.o: main.c linkedList.h ../CheckStruct/checkStruct.h
	gcc -c main.c

sClean: *.o
	rm -f *.o

clean: *.o output
	rm -f *.o output