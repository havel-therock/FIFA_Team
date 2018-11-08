JCC = javac

JFLAGS = -g

default: Test.class BST.class RBT.class

Test.class : Test.java
	$(JCC) $(JFLAGS) Test.java
	
BST.class: BST.java
	$(JCC) $(JFLAGS) BST.java
	
RBT.class: RBT.java
	$(JCC) $(JFLAGS) RBT.java
	
clean:
	$(RM) *.class
	
