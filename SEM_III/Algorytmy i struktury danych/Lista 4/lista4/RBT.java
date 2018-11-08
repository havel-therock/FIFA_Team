import java.awt.Color;

public class RBT {
	public int comparison=0,change=0,colorNr=0;
	
	//klasa wezla
	private class Node{
		String key = null;
		Color color = Color.red;
		Node left = null;
		Node right = null;
		Node parent = null;
		Node(String key){
			this.key = key;
		}
	}
		
	public Node root = null;
	private Node help = null;
		
	//przekolorowanie
	public void recolor(Node node,Color color) {
		if(node!=null) {
			colorNr++;
			node.color = color;
		}
	}
	
	//rotacja w lewo
	public void leftRotate(Node node) {
		comparison++;
		if (node.parent!=null) {
			comparison++;
			if (node==node.parent.left) {
				change++;
				node.parent.left = node.right;
			} 
			else {
				change++;
				node.parent.right = node.right;
			}
			change++;
			node.right.parent = node.parent;
			change++;
			node.parent = node.right;
			comparison++;
			if (node.right.left!=null) {
				change++;
				node.right.left.parent = node;
			}
			change++;
			node.right = node.right.left;
			change++;
			node.parent.left = node;
		} 
		else {
			Node right = root.right;
			change++;
			root.right = right.left;
			comparison++;
			if(right.left!=null) {
				change++;
				right.left.parent = root;
			}
			change++;
			root.parent = right;
			change++;
			right.left = root;
			change++;
			right.parent = null;
			change++;
			root = right;
		}
	}
	
	//rotacja w prawo
	public void rightRotate(Node node) {
		comparison++;
		if (node.parent!=null) {
			comparison++;
			if (node==node.parent.left) {
				change++;
				node.parent.left = node.left;
			} 
			else {
				change++;
				node.parent.right = node.left;
            }
			change++;
			node.left.parent = node.parent;
			change++;
			node.parent = node.left;
			comparison++;
			if (node.left.right!=null) {
				change++;
				node.left.right.parent = node;
			}
			change++;
			node.left = node.left.right;
			change++;
			node.parent.right = node;
        } 
		else {
			Node left = root.left;
			change++;
			root.left = root.left.right;
			comparison++;
			if(left.right!=null) {
				change++;
				left.right.parent = root;
			}
			change++;
			root.parent = left;
			change++;
			left.right = root;
			change++;
			left.parent = null;
			change++;
			root = left;
		}
	}
	
	//dodawanie elementow
	public void insert(String key) {
		Node node = insertBST(key);
		Node uncle = null;
		comparison++;
		while (node!=root && node.parent.color==Color.red) {
			comparison++;
			if (node.parent==((node.parent).parent).left) {
				change++;
				uncle = node.parent.parent.right;
				comparison++;
				if (uncle!=null && uncle.color==Color.red) {
					//case1
					recolor(node.parent,Color.black);
					recolor(uncle,Color.black);
					recolor(node.parent.parent,Color.red);
					change++;
					node = node.parent.parent;
					continue;
                } 
				comparison++;
				if (node==node.parent.right) {
					//case2
					change++;
	               	node = node.parent;
	               	leftRotate(node);
				}
				//case3
				recolor(node.parent,Color.black);
				recolor(node.parent.parent,Color.red);
	            rightRotate(node.parent.parent);
			}
			else {
				change++;
				uncle = node.parent.parent.left;
				comparison++;
				if (uncle!=null && uncle.color==Color.red) {
					//case1
					recolor(node.parent,Color.black);
					recolor(uncle,Color.black);
					recolor(node.parent.parent,Color.red);
					change++;
					node = node.parent.parent;
					continue;
				}
				comparison++;
				if (node==node.parent.left) {
					//case2
					change++;
					node = node.parent;
	               	rightRotate(node);
				}
				//case3
				recolor(node.parent,Color.black);
				recolor(node.parent.parent,Color.red);
				leftRotate(node.parent.parent);
			}
			comparison++;
		}
		recolor(root,Color.black);
	}
		
	public Node insertBST(String key) {
		comparison++;
		if(root==null) {
			root = new Node(key);
			return root;
		}
		else {
			Node actual = root;
			Node parent = null;
			comparison++;
			while(actual!=null) {
				change++;
				parent = actual;
				comparison++;
				if((actual.key).compareTo(key)>=0) {
					change++;
					actual = actual.left;
				}
				else {
					change++;
					actual = actual.right;
				}
			}
			comparison++;
			if((parent.key).compareTo(key)>=0) {
				parent.left = new Node(key);
				change++;
				parent.left.parent = parent;
				return parent.left;
			}
			else {
				parent.right = new Node(key);
				change++;
				parent.right.parent = parent;
				return parent.right;
			}
		}
	}
	
	//wyszukiwanie elementu
	public int find(String key) {
		Node search = search(key);
		comparison++;
		if(search==null) {
			System.out.println(0);
			return 0;
		}
		else {
			System.out.println(1);
			return 1;
		}
	}
	public Node search(String key) {
		Node actual = root;
		comparison++;
		while(actual!=null && (actual.key).compareTo(key)!=0) {
			comparison++;
			if((actual.key).compareTo(key)>=0) {
				change++;
				actual = actual.left;
			}
			else {
				change++;
				actual = actual.right;
			}
			comparison++;
		}
		comparison++;
		if(actual == null) {
			return null;
		}
		else {
			return actual;
		}
	}
	
	//znajdowanie elementu minimalnego
	public void min() {
		Node node = minNode(root);
		comparison++;
		if(node!=null) {
			System.out.println(node.key);
		}
		else {
			System.out.println();
		}
	}
	public Node minNode(Node node) {
		comparison++;
		if(node!=null) {
			comparison++;
			while(node.left!=null) {
				change++;
				node = node.left;
				comparison++;
			}
		}
		return node;
	}
	
	//znajdowanie elementu maksymalnego
	public void max() {
		Node node = maxNode(root);
		comparison++;
		if(node!=null) {
			System.out.println(node.key);
		}
		else {
			System.out.println();
		}
	}
	public Node maxNode(Node node) {
		comparison++;
		if(node!=null) {
			comparison++;
			while(node.right!=null) {
				change++;
				node = node.right;
				comparison++;
			}
		}
		return node;
	}
	
	//znajdowanie nastepnika
	public void successor(String key) {
		Node node = successorNode(key);
		comparison++;
		if(node!=null) {
			System.out.println(node.key);
		}
		else {
			System.out.println();
		}
	}
	public Node successorNode(String key) {
		Node node = this.search(key);
		comparison++;
		if(node!=null) {
			//gdy ma prawego syna
			comparison++;
			if(node.right!=null) {
				change++;
				node = node.right;
				node = minNode(node);
				return node;
			}
			//gdy nie ma prawego syna
			Node parent = node.parent;
			comparison++;
			while(parent!=null && node==parent.right) {
				change++;
				node = parent;
				change++;
				parent = parent.parent;
				comparison++;
			}
			return parent;
		}
		else {
			return node;
		}
	}
	
	//usuwanie elementu
	public void delete(String key) {
		comparison++;
		if(root!=null && find(key)==1) {
			Color c = this.remove(key).color;
			comparison++;
			if(c==Color.black) {
				deleteFixup(help);
			}
			else {
				recolor(help,Color.red);
			}
		}
	}
	public Node remove(String key) {
		Node node = this.search(key);
		Node parent = node.parent;
		Node n;
		comparison++;
		if(node.left!=null && node.right!=null) {
			n = this.remove(this.successorNode(key).key);
			change++;
			n.left = node.left;
			comparison++;
			if(n.left!=null) {
				change++;
				n.left.parent = n;
			}
			change++;
			n.right = node.right;
			comparison++;
			if(n.right!=null) {
				change++;
				n.right.parent = n;
			}
		}
		else {
			comparison++;
			if(node.left!=null) {
				change++;
				n = node.left;
			}
			else {
				change++;
				n = node.right;
			}
		}
		comparison++;
		if(n!=null) {
			change++;
			node.parent = node;
		}
		comparison++;
		if(parent==null) {
			change++;
			root = n;
		}
		else if(parent.left==node) {
			change++;
			parent.left = n;
		}
		else {
			change++;
			parent.right = n;
		}
		change++;
		help = n;
		return node;
	}
	
	public void deleteFixup(Node x) {
		comparison++;
		while(x!=root && x.color==Color.black) {
			comparison++;
			if (x.parent.left == x) {
				Node w = x.parent.right;
				comparison++;
				if (w.color==Color.red) {
					recolor(w,Color.black);
					recolor(x.parent,Color.red);
				    leftRotate(x.parent);
				    change++;
				    w = x.parent.right;
				}
				comparison++;
				if ((w.left).color==Color.black && (w.right).color==Color.black) {
					recolor(w,Color.red);
				    change++;
				    x = x.parent;
				}
				else {
					comparison++;
				    if ((w.right).color==Color.black) {
				    	recolor(w.left,Color.black);
				    	recolor(w,Color.red);
						rightRotate(w);
						change++;
						w = x.parent.right;
				    }
				    recolor(w,(x.parent).color);
				    recolor(x.parent,Color.black);
				    recolor(w.right,Color.black);
				    leftRotate(x.parent);
				    change++;
				    x = root;
				}
			    }
			    else {
				Node w = x.parent.left;
				comparison++;
				if (w.color==Color.red) {
					recolor(w,Color.black);
					recolor(x.parent,Color.red);
				    rightRotate(x.parent);
				    change++;
				    w = x.parent.left;
				}
				comparison++;
				if ((w.right).color==Color.black && (w.left).color==Color.black) {
					recolor(w,Color.red);
				    change++;
				    x = x.parent;
				}
				else {
					comparison++;
				    if ((w.left).color==Color.black) {
				    	recolor(w.right,Color.black);
				    	recolor(w,Color.red);
						leftRotate(w);
						change++;
						w = x.parent.left;
				    }
				    recolor(w,(x.parent).color);
				    recolor(x.parent,Color.black);
				    recolor(w.left,Color.black);
				    rightRotate(x.parent);
				    change++;
				    x = root;
				}		
			}
		}
		recolor(x,Color.black);
	}
		
	//wyswiertlanie w kolejnosci inorder
	public void inorder(Node node) {
		inorderNode(node);
		System.out.println();
	}
	public void inorderNode(Node node) {
		comparison++;
		if(node!=null) {
			inorderNode(node.left);
			System.out.print(node.key+" ");
			inorderNode(node.right);
		}
	}
	
	/**public static void main(String[] args){
		RBT tree = new RBT();
		tree.insert("d");
		tree.insert("f");
		tree.insert("g");
		tree.insert("e");
		tree.insert("b");
		tree.insert("c");
		tree.insert("a");
		
		tree.inorder(tree.root);
		
		System.out.println(tree.root.key+" "+String.valueOf(tree.root.color));
		System.out.println(tree.root.left.key+" "+String.valueOf(tree.root.left.color));
		System.out.println(tree.root.right.key+" "+String.valueOf(tree.root.right.color));
		System.out.println(tree.root.left.right.key+" "+String.valueOf(tree.root.left.right.color));
		System.out.println(tree.root.left.left.key+" "+String.valueOf(tree.root.left.left.color));
		System.out.println(tree.root.left.left.left.key+" "+String.valueOf(tree.root.left.left.left.color));
		System.out.println(tree.root.left.left.right.key+" "+String.valueOf(tree.root.left.left.right.color));
		
		tree.delete("d");System.out.println();
		
		System.out.println(tree.root.key+" "+String.valueOf(tree.root.color));
		System.out.println(tree.root.left.key+" "+String.valueOf(tree.root.left.color));
		System.out.println(tree.root.right.key+" "+String.valueOf(tree.root.right.color));
		System.out.println(tree.root.left.left.key+" "+String.valueOf(tree.root.left.left.color));
		System.out.println(tree.root.left.left.left.key+" "+String.valueOf(tree.root.left.left.left.color));
		System.out.println(tree.root.left.left.right.key+" "+String.valueOf(tree.root.left.left.right.color));
		
		tree.inorder(tree.root);
	}*/
}
