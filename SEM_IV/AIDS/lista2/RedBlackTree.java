

/**
 *
 * @author jakub
 */
public class RedBlackTree extends Structure implements DataStructure {

    private RedBlackNode nil = new RedBlackNode();
    private RedBlackNode root = nil;
    public int size;

    public RedBlackTree() {
        root.left = nil;
        root.right = nil;
        root.parent = nil;
    }

    void leftRotate(RedBlackNode x) {
        RedBlackNode y;
        y = x.right;
        x.right = y.left;

        // Check for existence of y.left and make pointer changes
        if (!isNil(y.left)) {
            y.left.parent = x;
        }
        y.parent = x.parent;

        // x's parent is nul
        if (isNil(x.parent)) {
            root = y;
        } // x is the left child of it's parent
        else if (x.parent.left == x) {
            x.parent.left = y;
        } // x is the right child of it's parent.
        else {
            x.parent.right = y;
        }

        // Finish of the leftRotate
        y.left = x;
        x.parent = y;
    }

    void rightRotate(RedBlackNode y) {
        RedBlackNode x = y.left;
        y.left = x.right;

        if (!isNil(x.right)) {
            x.right.parent = y;
        }
        x.parent = y.parent;

        if (isNil(y.parent)) {
            root = x;
        } else if (y.parent.right == y) {
            y.parent.right = x;
        } else {
            y.parent.left = x;
        }
        x.right = y;

        y.parent = x;
    }

    @Override
    public void insert(String s) {
        insert(new RedBlackNode(s));
        size++;
    }

    private void insert(RedBlackNode z) {
        RedBlackNode y = nil;
        RedBlackNode x = root;

        while (!isNil(x)) {
            y = x;

            if (z.value.compareToIgnoreCase(x.value) < 0) {

                // x.numLeft++;
                x = x.left;
            } else {

                //x.numRight++;
                x = x.right;
            }
        }
        z.parent = y;

        if (isNil(y)) {
            root = z;
        } else if (z.value.compareToIgnoreCase(y.value) < 0) {
            y.left = z;
        } else {
            y.right = z;
        }

        z.left = nil;
        z.right = nil;
        z.color = RedBlackNode.RED;

        insertFixup(z);
    }

    private void insertFixup(RedBlackNode z) {

        RedBlackNode y = nil;
        while (z.parent.color == RedBlackNode.RED) {

            if (z.parent == z.parent.parent.left) {

                y = z.parent.parent.right;

                // Case 1: if y is red...recolor
                if (y.color == RedBlackNode.RED) {
                    z.parent.color = RedBlackNode.BLACK;
                    y.color = RedBlackNode.BLACK;
                    z.parent.parent.color = RedBlackNode.RED;
                    z = z.parent.parent;
                } // Case 2: if y is black & z is a right child
                else if (z == z.parent.right) {

                    // leftRotaet around z's parent
                    z = z.parent;
                    leftRotate(z);
                } // Case 3: else y is black & z is a left child
                else {
                    // recolor and rotate round z's grandpa
                    z.parent.color = RedBlackNode.BLACK;
                    z.parent.parent.color = RedBlackNode.RED;
                    rightRotate(z.parent.parent);
                }
            } // If z's parent is the right child of it's parent.
            else {

                // Initialize y to z's cousin
                y = z.parent.parent.left;

                // Case 1: if y is red...recolor
                if (y.color == RedBlackNode.RED) {
                    z.parent.color = RedBlackNode.BLACK;
                    y.color = RedBlackNode.BLACK;
                    z.parent.parent.color = RedBlackNode.RED;
                    z = z.parent.parent;
                } // Case 2: if y is black and z is a left child
                else if (z == z.parent.left) {
                    // rightRotate around z's parent
                    z = z.parent;
                    rightRotate(z);
                } // Case 3: if y  is black and z is a right child
                else {
                    // recolor and rotate around z's grandpa
                    z.parent.color = RedBlackNode.BLACK;
                    z.parent.parent.color = RedBlackNode.RED;
                    leftRotate(z.parent.parent);
                }
            }
        }
        // Color root black at all times
        root.color = RedBlackNode.BLACK;

    }

    @Override
    public void delete(String s) {
        if (findx(s) == 1) {
            delete(search(s));
            size--;
        }
    }

    public void delete(RedBlackNode v) {

        RedBlackNode z = search(v.value);

        RedBlackNode x = nil;
        RedBlackNode y = nil;

        if (isNil(z.left) || isNil(z.right)) {
            y = z;
        } else {
            y = treeSuccessor(z);
        }
        if (!isNil(y.left)) {
            x = y.left;
        } else {
            x = y.right;
        }
        x.parent = y.parent;
        if (isNil(y.parent)) {
            root = x;
        } else if (!isNil(y.parent.left) && y.parent.left == y) {
            y.parent.left = x;
        } else if (!isNil(y.parent.right) && y.parent.right == y) {
            y.parent.right = x;
        }
        if (y != z) {
            z.value = y.value;
        }

        if (y.color == RedBlackNode.BLACK) {
            removeFixup(x);
        }
    }

    private void removeFixup(RedBlackNode x) {

        RedBlackNode w;

        // While we haven't fixed the tree completely...
        while (x != root && x.color == RedBlackNode.BLACK) {

            // if x is it's parent's left child
            if (x == x.parent.left) {

                // set w = x's sibling
                w = x.parent.right;

                // Case 1, w's color is red.
                if (w.color == RedBlackNode.RED) {
                    w.color = RedBlackNode.BLACK;
                    x.parent.color = RedBlackNode.RED;
                    leftRotate(x.parent);
                    w = x.parent.right;
                }

                // Case 2, both of w's children are black
                if (w.left.color == RedBlackNode.BLACK
                        && w.right.color == RedBlackNode.BLACK) {
                    w.color = RedBlackNode.RED;
                    x = x.parent;
                } // Case 3 / Case 4
                else {
                    // Case 3, w's right child is black
                    if (w.right.color == RedBlackNode.BLACK) {
                        w.left.color = RedBlackNode.BLACK;
                        w.color = RedBlackNode.RED;
                        rightRotate(w);
                        w = x.parent.right;
                    }
                    // Case 4, w = black, w.right = red
                    w.color = x.parent.color;
                    x.parent.color = RedBlackNode.BLACK;
                    w.right.color = RedBlackNode.BLACK;
                    leftRotate(x.parent);
                    x = root;
                }
            } // if x is it's parent's right child
            else {

                // set w to x's sibling
                w = x.parent.left;

                // Case 1, w's color is red
                if (w.color == RedBlackNode.RED) {
                    w.color = RedBlackNode.BLACK;
                    x.parent.color = RedBlackNode.RED;
                    rightRotate(x.parent);
                    w = x.parent.left;
                }

                // Case 2, both of w's children are black
                if (w.right.color == RedBlackNode.BLACK
                        && w.left.color == RedBlackNode.BLACK) {
                    w.color = RedBlackNode.RED;
                    x = x.parent;
                } // Case 3 / Case 4
                else {
                    // Case 3, w's left child is black
                    if (w.left.color == RedBlackNode.BLACK) {
                        w.right.color = RedBlackNode.BLACK;
                        w.color = RedBlackNode.RED;
                        leftRotate(w);
                        w = x.parent.left;
                    }

                    // Case 4, w = black, and w.left = red
                    w.color = x.parent.color;
                    x.parent.color = RedBlackNode.BLACK;
                    w.left.color = RedBlackNode.BLACK;
                    rightRotate(x.parent);
                    x = root;
                }
            }
        }// end while

        // set x to black to ensure there is no violation of
        // RedBlack tree Properties
        x.color = RedBlackNode.BLACK;
    }

    @Override
    public void find(String s) {
        if (search(s) == null) {
            System.out.print(0);
        } else {
            System.out.print(1);
        }
    }

    public int findx(String s) {
        if (search(s) == null) {
            return 0;
        } else {
            return 1;
        }
    }

    @Override
    public void min() {
        RedBlackNode node = root;
        while (!isNil(node.left)) {
            node = node.left;
        }
        System.out.println(node.value);
    }

    @Override
    public void max() {
        System.out.println("Szukam maksa");
        RedBlackNode node = root;
        while (!isNil(node.right)) {
            node = node.right;
        }
        System.out.println(node.value);
    }

    @Override
    public void inorder() {
        inorderWalk(root);
        System.out.println();
    }

    public String inorderX() {
        String s = " ";
        return inorderWalk(root, s);

    }

    private String inorderWalk(RedBlackNode node, String s) {
        if (!isNil(node)) {
            inorderWalk(node.left, s);
            s += node.value + " ";
            inorderWalk(node.right, s);
        }
        return s;
    }

    private void inorderWalk(RedBlackNode node) {
        if (!isNil(node)) {
            inorderWalk(node.left);
            System.out.print(node.value + " , ");
            inorderWalk(node.right);
        }
    }

    private RedBlackNode search(String value) {
        RedBlackNode current = root;
        while (!isNil(current)) {
            if (current.value.equals(value)) {
                return current;
            } else if (current.value.compareToIgnoreCase(value) < 0) {
                current = current.right;
            } else {
                current = current.left;
            }
        }
        return null;
    }

    private boolean isNil(RedBlackNode temp) {
        return temp == nil;
    }

    private RedBlackNode treeSuccessor(RedBlackNode x) {
        if (!isNil(x.left)) {
            return treeMinimum(x.right);
        }

        RedBlackNode y = x.parent;

        while (!isNil(y) && x == y.right) {
            x = y;
            y = y.parent;
        }
        return y;
    }

    private RedBlackNode treeMinimum(RedBlackNode node) {
        while (!isNil(node.left)) {
            node = node.left;
        }
        return node;
    }

}
