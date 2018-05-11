
public class BST extends Structure implements DataStructure {

    Node root;

    Node searchNode(Node node, String s) {
        if (node == null) {
            return null;
        }
        if ((node.value.compareToIgnoreCase(s)) == 0) {
            return node;
        } else if ((node.value.compareToIgnoreCase(s)) <= 0) {
            return searchNode(node.right, s);
        } else {
            return searchNode(node.left, s);
        }
    }

    String findExtremum(Node node, boolean b) {
        if (b) {
            if (node.right == null) {
                return node.value;
            } else {
                return findExtremum(node.right, b);
            }
        } else if (node.left == null) {
            return node.value;
        } else {
            return findExtremum(node.left, b);
        }
    }

    public Node successorHelp(Node k) {
        if (k.right != null) {
            System.out.println(findExtremum(k, false));
            return null;
        }
        Node y = k.parent;
        while (y != null && k == y.right) {
            k = y;
            y = y.parent;
        }
        return y;
    }
    
    @Override
    public void insert(String s) {
		if(root==null){
			root = new Node(s,null);
			return;
		}
		Node temp=root;
		while(true){
			if((temp.value.compareTo(s))<=0){
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


    void inorderWalk(Node node) {
        if (node != null) {
            inorderWalk(node.left);
            System.out.print(node.value + " , ");
            inorderWalk(node.right);
        }
    }

    @Override
    public void delete(String s) {
        Node node = searchNode(root, s);
        if (node == null) {
            return;
        }
        if (node == root) {
            root = null;
            return;
        }
        //zero poddrzew
        Node parent = node.parent;
        if (node.left == null && node.right == null) {
            if (node.value.compareToIgnoreCase(parent.value) <= 0) {
                parent.left = null;
            } else {
                parent.right = null;
            }
            return;
        }

        //jedno poddrzewo
        if (node.left != null) {
            if (node.value.compareToIgnoreCase(parent.value) <= 0) {
                parent.left = node.left;
                node.left.parent = parent;
            } else {
                parent.right = node.left;
                node.left.parent = parent;
            }
            return;
        }

        if (node.right != null) {
            if (node.value.compareToIgnoreCase(parent.value) <= 0) {
                parent.left = node.right;
                node.right.parent = parent;
            } else {
                parent.right = node.right;
                node.right.parent = parent;
            }
            return;
        }
        //dwa poddrzewa
        Node next = successorHelp(node);
        next.parent = node.parent;
        next.left = node.left;
        next.right = node.right;
        node.left.parent = next;
        node.right.parent = next;
        if (node.value.compareToIgnoreCase(parent.value) <= 0) {
            parent.left = next;
        } else {
            parent.right = next;
        }
        return;
    }

    @Override
    public void find(String s) {
        if (searchNode(root, s) == null) {
            System.out.print(0);
        } else {
            System.out.print(1);
        }
    }

    @Override
    public void min() {
        System.out.print(findExtremum(root, false));
    }

    @Override
    public void max() {
        System.out.print(findExtremum(root, true));
    }

    
    @Override
    public void successor(Object k) {
        Node y = successorHelp((Node) k);
        if (y != null) {
            System.out.print(y.value);
        }
    }

    @Override
    public void inorder() {
        inorderWalk(root);
        System.out.println();
    }

}
