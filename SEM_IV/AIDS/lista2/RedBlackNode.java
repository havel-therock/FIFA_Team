import java.awt.Color;

/**
 *
 * @author jakub
 */
public class RedBlackNode {

    public static final int BLACK = 0;
    public static final int RED = 1;
    RedBlackNode left;
    RedBlackNode right;
    RedBlackNode parent;
    String value;
    int color;

    public RedBlackNode(String s) {
        this();
        value = s;

    }

    public RedBlackNode(String s, RedBlackNode parent) {
        this.value = s;
        this.parent = parent;
    }

    public RedBlackNode() {
        color = BLACK;
        parent = null;
        left = null;
        right = null;
    }

}
