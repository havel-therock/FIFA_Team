
public class Hmap extends Structure implements DataStructure {

    private Object[] table;
    public static int arraySize = 31;
    public static int toLink = 100;
    public static int toRBT = 80;


    /* Constructor */
    public Hmap() {

        table = new Object[arraySize];

    }


    /* Function to insert an element */
    @Override
    public void insert(String val) {
        int pos = myhash(val);

        if (table[pos] == null || table[pos].getClass() == SLLNode.class) {
            insertLink(val);
        } else {
            RedBlackTree x = (RedBlackTree) table[pos];
            x.insert(val);
            table[pos] = x;
        }
    }

    private void insertLink(String val) {
        int pos = myhash(val);
        SLLNode nptr = new SLLNode(val);

        if (table[pos] == null) {
            table[pos] = nptr;
        } else {
            nptr.next = (SLLNode) table[pos];
            table[pos] = nptr;
            SLLNode x = nptr;
            while (x != null) {
                nptr.size++;
                x = x.next;
            }
            if (nptr.size > toRBT) {
                table[pos] = (RedBlackTree) linkToRbt(nptr);
            }
        }
    }

    /* Function to delete an element */
    @Override
    public void delete(String val) {
        int pos = myhash(val);
        if (table[pos].getClass() == SLLNode.class) {
            deleteLink(val);
        } else {
            RedBlackTree x = (RedBlackTree) table[pos];
            x.delete(val);
            table[pos] = x;
            if (x.size < toLink) {
                rbtToLink(x);
            }
        }
    }

    private void deleteLink(String val) {
        int pos = myhash(val);
        SLLNode start = (SLLNode) table[pos];
        SLLNode end = start;
        if (start.data.equals(val)) {
            table[pos] = start.next;
            return;
        }
        while (end.next != null && !end.next.data.equals(val)) {
            end = end.next;
        }
        if (end.next == null) {
            System.out.println("\nElement not found\n");
            return;
        }
        if (end.next.next == null) {
            end.next = null;
            return;
        }
        end.next = end.next.next;
        table[pos] = start;
    }

    /* Function myhash */
    private int myhash(String wordToHash) {
        int hashKeyValue = 0;

        for (int i = 0; i < wordToHash.length(); i++) {
            int charCode = wordToHash.toLowerCase().charAt(i) - 96;
            hashKeyValue = (hashKeyValue * 27 + charCode) % arraySize;
        }
        return hashKeyValue;

    }

    @Override
    public void find(String wordToFind) {
        int pos = myhash(wordToFind);
        if (table[pos].getClass() == SLLNode.class) {
            findLink(wordToFind);
        } else {
            RedBlackTree x = (RedBlackTree) table[pos];
            System.out.println(x.findx(wordToFind));
        }
    }

    public void findLink(String wordToFind) {
        int hashKey = myhash(wordToFind);
        if (findString(wordToFind, (SLLNode) table[hashKey])) {
            System.out.println("1");
        } else {
            System.out.println("0");
        }
    }

    private boolean findString(String wordToFind, SLLNode x) {
        while (x != null) {
            if (x.data.equals(wordToFind)) {
                return true;
            } else {
                x = x.next;
            }
        }
        return false;

    }

    private RedBlackTree linkToRbt(SLLNode x) {
        RedBlackTree rbt = new RedBlackTree();
        while (x != null) {
            rbt.insert(x.data);
            x = x.next;
        }
        return rbt;
    }

    private void rbtToLink(RedBlackTree x) {
        String s = x.inorderX();
        String[] words = s.split(" ");
        int hashKey = myhash(words[0]);
        table[hashKey] = null;
        for (String w : words) {
            insert(w);
        }

    }
}

class SLLNode {

    SLLNode next;
    String data;
    int size = 0;


    /* Constructor */
    public SLLNode(String x) {
        data = x;
        next = null;
    }
}
