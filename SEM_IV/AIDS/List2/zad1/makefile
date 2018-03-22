
JCC = javac

JFLAGS = -g

default: main.class InsertionSort.class QuickSort.class MergeSort.class

	
main.class: main.java
	$(JCC) $(JFLAGS)  main.java
	
InsertionSort.class: InsertionSort.java
	$(JCC) $(JFLAGS) InsertionSort.java

QuickSort.class: QuickSort.java
	$(JCC) $(JFLAGS) QuickSort.java

MergeSort.class: MergeSort.java
	$(JCC) $(JFLAGS) MergeSort.java
	
clean: 
	$(RM) *.class	
