JCC = javac

JFLAGS = -g

default: PriorityQueue.class QueueElement.class

PriorityQueue.class : PriorityQueue.java
	$(JCC) $(JFLAGS) Main.java
	
QueueElement.class: QueueElement.java
	$(JCC) $(JFLAGS) QueueElement.java
	
clean:
	$(RM) *.class
	
