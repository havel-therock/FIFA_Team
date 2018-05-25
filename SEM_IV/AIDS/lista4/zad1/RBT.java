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
		if(node==nil)
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
	
	String findExtremum(NodeRBT node, boolean b) {
		if(b){
			if(node.right==nil)
				return node.value;
			else
				return findExtremum(node.right, b);
		}
		else{
			if(node.left==nil)
				return node.value;
			else
				return findExtremum(node.left, b);
		}
	}

	 public int findx(String s) {
	        if (searchNode(root,s) == null) {
	            return 0;
	        } else {
	            return 1;
	        }
	    }
	 
	public NodeRBT successorHelp(NodeRBT k){
		NodeRBT y=k.parent;
		if(k.right!=nil){
			y=k.right;
			while(y.left!=nil)
				y=y.left;
			return y;
		}
		while(y!=nil && k==y.right){
			k=y;
			y=y.parent;
		}
		return y;
	}
	
	void inorderWalk(NodeRBT node) {
		if(node!=null){
			inorderWalk(node.left);
			if(node.value!=null)
				System.out.print(node.value + " , ");
			inorderWalk(node.right);
		}			
	}
	public String inorderX() {
        String s = " ";
        return inorderWalkSecond(root, s);

    }

    private String inorderWalkSecond(NodeRBT node, String s) {
        if (node!=nil) {
            inorderWalkSecond(node.left, s);
            s += node.value + " ";
            inorderWalkSecond(node.right, s);
        }
        return s;
    }
    
	public void leftRotate(RBT T, NodeRBT node){
		NodeRBT y = node.right;
		node.right = y.left;
		if(y.left!=nil)
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
		//System.out.println("XX" + node.parent.left.parent.value);
		if(y.right!=nil)
			y.right.parent = node;
		//System.out.println("XX1" + node.parent.left.parent.value);
		y.parent = node.parent;
		//System.out.println("XX1" + node.parent.left.parent.value);
		if(node.parent==nil)
			root = y;
		else if(node==node.parent.left){
				node.parent.left = y;
		}
			 else{
				node.parent.right = y;
			//	System.out.println("XX2" + node.parent.left.parent.value);
			 }
		y.right = node;
		//System.out.println("XX" + node.parent.left.parent.value);
		node.parent = y;
	}
	
	public void insert(String s) {
		size++;
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
			if((temp.value.compareToIgnoreCase(s))<=0){
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
					if(z == z.parent.left){
						 z =z.parent;
						 rightRotate(this, z);
					}
					z.parent.color=Color.BLACK;
					z.parent.parent.color=Color.RED;
					leftRotate(this, z.parent.parent);
				}
			}
		}
		root.color = Color.BLACK;
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
		NodeRBT node=searchNode(root,s);
		NodeRBT x = nil;
	    NodeRBT y = nil;
	    if(node!=null)
	    	  size--;
	    else
	    	return;
	    
	        if (node.left == nil || node.right==nil) {
	    
	            y = node;
	        } else {
	         	
	            y = successorHelp(node);
	        }
	        if (y.left!=nil) {
	        	
	            x = y.left;
	        } else {
	            x = y.right;
	          
	        }
	        x.parent = y.parent;
	        if (y.parent==nil) {
	            root = x;
	        } else if (y.parent.left!=nil && y.parent.left == y) {
	            y.parent.left = x;
	         
	        } else if (y.parent.right!=nil && y.parent.right == y) {
	            y.parent.right = x;
	           
	        }
	        if (y != node) {
	            node.value = y.value;
	        }
	        if (y.color == Color.BLACK) {
	            deleteFix(x);
	        }
		
	}

	private void deleteFix(NodeRBT x) {
		NodeRBT w;
		while(x!=root && x.color == Color.BLACK){
			if(x==x.parent.left){
				//System.out.println(x.parent.left.value + " x");
				//System.out.println(x.parent.right.value);
				//System.out.println(x.value);
				w = x.parent.right;
				if(w.color==Color.RED){
					w.color=Color.BLACK;
					x.parent.color=Color.RED;
					leftRotate(this, x.parent);
					w = x.parent.right;
				//	System.out.println("1");
				}
				if(w.left.color==Color.BLACK && w.right.color ==Color.BLACK){
					w.color=Color.RED;
					x=x.parent;
					//System.out.println("tutaj");
				} else {
					if(w.right.color==Color.BLACK){
						w.left.color=Color.BLACK;
						w.color=Color.RED;
						//System.out.println(x.parent.left.value);
						//System.out.println(x.parent.right.value);
						rightRotate(this, w);
						w=x.parent.right;
						//System.out.println(x.parent.value);
					}
					w.color=x.parent.color;
					//System.out.println("3");
					x.parent.color=Color.BLACK;
					//System.out.println(w.value);
					//System.out.println(w.right);
					w.right.color=Color.BLACK;
					leftRotate(this, x.parent);
					x=root;
				}
			} else {
				w = x.parent.left;
				if(w.color==Color.RED){
					w.color=Color.BLACK;
					x.parent.color=Color.RED;
					leftRotate(this, x.parent);
					w = x.parent.left;
				}
				if(w.left.color==Color.BLACK && w.right.color == Color.BLACK){
					w.color=Color.RED;
					x=x.parent;
				} else {
					if(w.left.color==Color.BLACK){
						w.right.color=Color.BLACK;
						w.color=Color.RED;
						leftRotate(this, w);
						w=x.parent.left;
					}
					w.color=x.parent.color;
					x.parent.color=Color.BLACK;
					w.left.color=Color.BLACK;
					rightRotate(this, x.parent);
					x=root;
				}
			}
		}
	}

	public void find(String s) {
		if(searchNode(root,s)==null)
			System.out.print(0);
		else
			System.out.print(1);
	}

	public void min() {
		if(root!=nil)
			System.out.print(findExtremum(root,false));
	}

	public void max() {
		if(root!=nil)
			System.out.print(findExtremum(root,true));
	}

	public void successor(String s) {
		NodeRBT k = searchNode(root, s);
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