import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.ParseConversionEvent;


public class RBT extends DataStructure  {

	NodeRBT nil=new NodeRBT();
	NodeRBT root=nil;
	
	RBT(){
		root.color=Color.BLACK;
	}
	
	NodeRBT searchNode(NodeRBT node, String s) {
		if(node==null)
			return null;
		if((node.value.compareTo(s))==0)
			return node;
		else if((node.value.compareTo(s))<=0){
			return searchNode(node.right,s);
		} else
			return searchNode(node.left,s);
	}
	
	String findExtremum(NodeRBT node, boolean b) {
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

	public NodeRBT successorHelp(NodeRBT k){
		if(k.right!=null){
			System.out.println(findExtremum(k,false));
			return null;
		}
		NodeRBT y=k.parent;
		while(y!=null && k==y.right){
			k=y;
			y=y.parent;
		}
		return y;
	}
	
	void inorderWalk(NodeRBT node) {
		if(node!=null){
			inorderWalk(node.left);
			System.out.print(node.value + " , ");
			inorderWalk(node.right);
		}			
	}

	public void leftRotate(RBT T, NodeRBT node){
		NodeRBT y = node.right;
		node.right = y.left;
		y.left.parent = node;
		y.parent = node.parent;
		if(node.parent==nil)
			root = y;
		else if(node==node.parent.left)
				node.parent.left = y;
			 else
				node.parent.right = y;
		y.left = node;
		node.parent = y;
	}
	
	public void rightRotate(RBT T, NodeRBT node){
		NodeRBT y = node.left;
		node.left = y.right;
		y.right.parent = node;
		y.parent = node.parent;
		if(node.parent==nil)
			root = y;
		else if(node==node.parent.left)
				node.parent.left = y;
			 else
				node.parent.right = y;
		y.right = node;
		node.parent = y;
	}
	
	public void insert(String s) {
		if(root==nil){
			root = new NodeRBT(s,nil);
			root.color = Color.BLACK;
			root.parent=nil;
			root.left=nil;
			root.right=nil;
			return;
		}
		NodeRBT temp=root;
		while(true){
			if((temp.value.compareTo(s))<=0){
				if(temp.right==nil){
					temp.right=new NodeRBT(s,temp);
					temp.right.left=nil;
					temp.right.right=nil;
					temp.right.color = Color.RED;
					insertFix(temp.right);
					return;
				}
				else
					temp=temp.right;			
			}
			else{
				if(temp.left==nil){
					temp.left=new NodeRBT(s,temp);
					temp.left.left=nil;
					temp.left.right=nil;
					temp.left.color = Color.RED;
					insertFix(temp.left);
					return;
				}
				else
					temp=temp.left;
			}
		}
	}

	private void insertFix(NodeRBT z) {
		NodeRBT y;
		while (z.parent.color==Color.RED){
			if(z.parent == z.parent.parent.left){
				y = z.parent.parent.right;
				if(y.color==Color.RED){
					z.parent.color = Color.BLACK;
					y.color = Color.BLACK;
					z.parent.parent.color = Color.RED;
					z = z.parent.parent;
				} else { 
					if(z == z.parent.right){
						 z =z.parent;
						 leftRotate(this, z);
					}
					z.parent.color=Color.BLACK;
					z.parent.parent.color=Color.RED;
					rightRotate(this, z.parent.parent);
				}
			} else {
				y = z.parent.parent.left;
				if(y.color==Color.RED){
					z.parent.color = Color.BLACK;
					y.color = Color.BLACK;
					z.parent.parent.color = Color.RED;
					z = z.parent.parent;
				} else { 
					if(z == z.parent.right){
						 z =z.parent;
						 leftRotate(this, z);
					}
					z.parent.color=Color.BLACK;
					z.parent.parent.color=Color.RED;
					rightRotate(this, z.parent.parent);
				}
			}
		}
		root.color = Color.BLACK;
	}

	public void load(String f) {
		System.out.println("zz");
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
			for(int i=0; i< strings.length;i++)
				insert(strings[i]);
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
		NodeRBT node=searchNode(root,s);
		if(node==null)
			return;
		if(node==root){
			root=null;
			return;
		}
		//zero poddrzew
		NodeRBT parent=node.parent;
		if(node.left==null && node.right==null){
			if(node.value.compareTo(parent.value)<=0)
				parent.left=null;
			else
				parent.right=null;
			return;
		}
		
		//jedno poddrzewo
		if(node.left!=null){
			if(node.value.compareTo(parent.value)<=0){
				parent.left=node.left;
				node.left.parent=parent;
			}
			else{
				parent.right=node.left;
				node.left.parent=parent;
			}
			return;
		}
		
		if(node.right!=null){
			if(node.value.compareTo(parent.value)<=0){
				parent.left=node.right;
				node.right.parent=parent;
			}
			else{
				parent.right=node.right;
				node.right.parent=parent;
			}
			return;
		}
		//dwa poddrzewa
		NodeRBT next = successorHelp(node);
		next.parent =node.parent;
		next.left=node.left;
		next.right=node.right;
		node.left.parent=next;
		node.right.parent=next;
		if(node.value.compareTo(parent.value)<=0){
			parent.left=next;
		}
		else{
			parent.right=next;
		}
		return;
	}

	public void find(String s) {
		if(searchNode(root,s)==null)
			System.out.print(0);
		else
			System.out.print(1);
	}

	public void min() {
		System.out.print(findExtremum(root,false));
	}

	public void max() {
		System.out.print(findExtremum(root,true));
	}

	public void successor(NodeRBT k) {
		NodeRBT y=successorHelp(k);
		if(y!=null)
			System.out.print(y.value);
	}

	public void inorder() {
		inorderWalk(root);
		System.out.println();
	}

}

class NodeRBT {
	NodeRBT left;
	NodeRBT right;
	NodeRBT parent;
	String value;
	Color color; 
	
	public NodeRBT(String s,NodeRBT parent) {
		this.value=s;
		this.parent=parent;
	}

	public NodeRBT() {
	}
	
	
}

enum Color {
    RED, BLACK;
}