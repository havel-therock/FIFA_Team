JCC = javac

JFLAGS = -g

default: Pqueue.class Djikstra.class

Pqueue.class : Pqueue.java
	$(JCC) $(JFLAGS) Pqueue.java

Djikstra.class : Djikstra.java
	$(JCC) $(JFLAGS) Djikstra.java

clean: 
	$(RM) *.class
