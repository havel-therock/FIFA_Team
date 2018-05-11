
/**
 *
 * @author jakub
 */
public class Node {

    Node left;
    Node right;
    Node parent;
    String value;

    public Node(String s, Node parent) {
        this.value = s;
        this.parent = parent;
    }

}
