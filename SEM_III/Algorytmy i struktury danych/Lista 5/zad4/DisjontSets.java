public class DisjontSets {
    Node nodeTab[];
    int lastNode=0;

    private class Node{
        int x;
        int rank;
        Node parent;

        Node(int x,int rank,Node parent){
            this.x = x;
            this.rank = rank;
            this.parent = parent;
        }
    }

    DisjontSets(int nodeNum){
        nodeTab = new Node[nodeNum];
    }

    public void makeset(int x){
        nodeTab[lastNode] = new Node(x,0,null);
        nodeTab[lastNode].parent = nodeTab[lastNode];
        lastNode++;
    }

    public Node find(Node x){
        while(x!=x.parent){
            x = x.parent;
        }
        return x;
    }

    public void union(Node x, Node y){
        Node rx = find(x);
        Node ry = find(y);
        if(rx!=ry){
            if(rx.rank>ry.rank){
                ry.parent = rx;
            }
            else{
                rx.parent = ry;
                if(rx.rank==ry.rank){
                    ry.rank++;
                }
            }
        }
    }

    public Node findNode(int x){
        for(int i=0;i<nodeTab.length;i++){
            if(nodeTab[i].x==x){
                return nodeTab[i];
            }
        }
        return null;
    }

    /*public static void main(String [] args){
        DisjontSets ds = new DisjontSets(4);
        ds.makeset(1);
        ds.makeset(2);
        ds.makeset(3);
        ds.makeset(4);
        //System.out.print(ds.nodeTab[0].parent.x);
        ds.union(ds.findNode(1),ds.findNode(2));
        ds.union(ds.findNode(3),ds.findNode(4));
        ds.union(ds.findNode(2),ds.findNode(3));
        System.out.print(ds.nodeTab[0].rank);
        System.out.print(ds.nodeTab[1].rank);
        System.out.print(ds.nodeTab[2].rank);
        System.out.print(ds.nodeTab[3].rank);
        System.out.println();
        Node n = ds.nodeTab[0];
        for(int i=0;i<3;i++){
            System.out.print(n.x+"---");
            n = n.parent;
        }
    }*/
}
