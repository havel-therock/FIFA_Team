JCC = javac

JFLAGS = -g

default: Builder.class BST.class RBT.class Hmap.class DataStructure.class

Builder.class : Builder.java
	$(JCC) $(JFLAGS) Builder.java
	
BST.class: BST.java
	$(JCC) $(JFLAGS) BST.java
	
RBT.class: RBT.java
	$(JCC) $(JFLAGS) RBT.java

Hmap.class: Hmap.java
	$(JCC) $(JFLAGS) Hmap.java
	
DataStructure.class: DataStructure.java
	$(JCC) $(JFLAGS) DataStructure.java

clean:
	$(RM) *.class
	
