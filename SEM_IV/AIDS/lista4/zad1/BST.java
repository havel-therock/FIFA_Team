
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class BST extends DataStructure  {

	Node root;
	
	Node searchNode(Node node, String s) {
		if(node==null)
			return null;
		if((node.value.compareTo(s))==0){
			return node;
		}
		else if((node.value.compareToIgnoreCase(s))<=0){
			return searchNode(node.right,s);
		} else{
			return searchNode(node.left,s);
		}
	}
	
	String findExtremum(Node node, boolean b) {
		if(b){
			if(node.right==null)
				return node.value;
			else
				return findExtremum(node.right, b);
		}
		else{
			if(node.left==null)
				return node.value;
			else
				return findExtremum(node.left, b);
		}
	}

	public void successor(String s) {
		Node k = searchNode(root, s);
		Node y=successorHelp(k);
		if(y!=null)
			System.out.print(y.value);
	}
	
	public Node successorHelp(Node k){
		Node y=k.parent;
		if(k.right!=null){
			y=k.right;
			while(y.left!=null)
				y=y.left;
			return y;
		}
		while(y!=null && k==y.right){
			k=y;
			y=y.parent;
		}
		return y;
	}
	
	void inorderWalk(Node node) {
		if(node!=null){
			inorderWalk(node.left);
			if(node.value!=null)
				System.out.print(node.value + " , ");
			inorderWalk(node.right);
		}			
	}

	public void insert(String s) {
		size++;
		if(root==null){
			root = new Node(s,null);
			return;
		}
		Node temp=root;
		while(true){
			if((temp.value.compareToIgnoreCase(s))<=0){
				if(temp.right==null){
					temp.right=new Node(s,temp);
					return;
				}
				else
					temp=temp.right;			
			}
			else{
				if(temp.left==null){
					temp.left=new Node(s,temp);
					return;
				}
				else
					temp=temp.left;
			}
		}
	}

	public void load(String f) {
		//System.out.println("zz");
		BufferedReader abc;
		try {
			abc = new BufferedReader(new FileReader(f));
			String text="";
	
			String line;
			while((line = abc.readLine()) != null) {
			    text+=line;
			   // System.out.println();
			}
			String[] strings;
			strings = text.split("\\s+");
			for(int i=0; i< strings.length;i++){
				//System.out.println("OO " + strings[i]);
				insert(strings[i].replaceAll("[^a-zA-Z]", ""));
			}
			abc.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void delete(String s) {
		Node node=searchNode(root,s);
		Node x = null;
	    Node y = null;    	
	    if(node!=null)
	    	size--;
	    else
	    	return;
	    
	        if (node.left == null || node.right==null) {	    
	            y = node;
	        } else {	         	
	            y = successorHelp(node);
	        }
	        if (y.left!=null) {
	        	
	            x = y.left;
	        } else {
	            x = y.right;
	          
	        }
	        if(x!=null)
	        	x.parent = y.parent;
	        if (y.parent==null) {
	            root = x;
	        } else if (y.parent.left!=null && y.parent.left == y) {
	            y.parent.left = x;
	         
	        } else if (y.parent.right!=null && y.parent.right == y) {
	            y.parent.right = x;
	           
	        }
	        if (y != node) {
	            node.value = y.value;
	        }
	   
	}

	public void find(String s) {
		if(searchNode(root,s)==null)
			System.out.print(0);
		else
			System.out.print(1);
	}

	public void min() {
		if(root!=null)
			System.out.print(findExtremum(root,false));
	}

	public void max() {
		if(root!=null)
			System.out.print(findExtremum(root,true));
	}


	public void inorder() {
		inorderWalk(root);
		System.out.println();
	}

}

class Node {
	Node left;
	Node right;
	Node parent;
	String value;
	
	public Node(String s,Node parent) {
		this.value=s;
		this.parent=parent;
	}
	
	
}