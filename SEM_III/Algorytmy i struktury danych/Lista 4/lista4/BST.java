
public class BST {
	public int comparison=0,change=0;
	
	//klasa wezla
	private class Node{
		String key = null;
		Node left = null;
		Node right = null;
		Node parent = null;
		Node(String key){
			this.key = key;
		}
	}
	
	public Node root = null;
	
	//dodawanie elementow
	public void insert(String key) {
		comparison++;
		if(root==null) {
			root = new Node(key);
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
			}
			else {
				parent.right = new Node(key);
				change++;
				parent.right.parent = parent;
			}
		}
	}
	
	//wyszukiwanie elementu
	public int find(String key) {
		Node search = search(key);
		comparison++;
		if(search==null) {
			return 0;
		}
		else {
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
			while(node.left!=null) {
				change++;
				node = node.left;
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
			while(node.right!=null) {
				change++;
				node = node.right;
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
				change++;
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
			this.remove(key);
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
		return node;
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
}
