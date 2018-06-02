import java.util.Scanner;

public class zad3 {
    int verticesNum;
    int edgeNum;
    double edgeWeight[][];
    PriorityQueue2 pqK;
    PriorityQueue pqP;
    DisjontSets ds;
    int edgeMST[][];
    double cost[];
    int prev[];
    double infinity = Double.POSITIVE_INFINITY;

    zad3(int verticesNum,int edgeNum){
        this.verticesNum = verticesNum;
        this.edgeNum = edgeNum;
        edgeWeight = new double[verticesNum][verticesNum];
        ds = new DisjontSets(verticesNum);
        pqK = new PriorityQueue2(edgeNum);
        edgeMST = new int[verticesNum][verticesNum];
        for(int i=0;i<verticesNum;i++){
            for(int j=0;j<verticesNum;j++){
                edgeMST[i][j]=0;
            }
        }
        for(int i=0;i<verticesNum;i++){
            for(int j=0;j<verticesNum;j++){
                if(j==i){
                    edgeWeight[i][j] = 0;
                }
                else {
                    edgeWeight[i][j] = -1;
                }
            }
        }
        cost = new double[verticesNum];
        prev = new int[verticesNum];
        pqP = new PriorityQueue(verticesNum);
    }

    public void prim(){
        for(int i=0;i<verticesNum;i++){
            cost[i] = infinity;
            prev[i] = -1;
        }
        cost[0] = 0;
        for(int i=0;i<verticesNum;i++){
            pqP.insert(i,cost[i]);
        }
        while(pqP.empty()==0){
            int v = pqP.popInt();
            for(int i=0;i<verticesNum;i++){
                if(edgeWeight[v][i]>-1){
                    if(cost[i]>edgeWeight[v][i] && v!=i){
                        cost[i] = edgeWeight[v][i];
                        prev[i] = v;
                        pqP.priority(i,cost[i]);
                    }
                }
            }
        }
    }

    public void kruskal(){
        for(int i=0;i<verticesNum;i++){
            ds.makeset(i);
        }
        for(int i=0;i<verticesNum;i++){
            for(int j=i;j<verticesNum;j++){
                if(edgeWeight[i][j]!=-1 && i!=j){
                    pqK.insert(i,j,edgeWeight[i][j]);
                }
            }
        }
        for(int i=0;i<edgeNum;i++){
            QueueElement2 tmp = pqK.pop();
            if(ds.find(ds.findNode(tmp.u))!=ds.find(ds.findNode(tmp.v))){
                edgeMST[tmp.u][tmp.v] = 1;
                edgeMST[tmp.v][tmp.u] = 1;
                ds.union(ds.findNode(tmp.u),ds.findNode(tmp.v));
            }
        }
    }

    public void print(int alg){
        double weight = 0;
        if(alg==1) {//kruskal
            for (int i = 0; i < verticesNum; i++) {
                for (int j = i; j < verticesNum; j++) {
                    if (edgeMST[i][j] == 1) {
                        System.out.println(i + " " + j + " " + edgeWeight[i][j]);
                        weight = weight + edgeWeight[i][j];
                    }
                }
            }
        }
        else {//prim
            for (int i = 0; i < verticesNum; i++) {
                if (prev[i] != -1) {
                    System.out.println(i + " " + prev[i] + " " + edgeWeight[i][prev[i]]);
                    weight = weight + edgeWeight[i][prev[i]];
                }
            }
        }
        System.out.println("waga: "+weight);
    }

    public void addEdge(int u,int v,double w){
        this.edgeWeight[u][v] = w;
        this.edgeWeight[v][u] = w;
    }

    public static void main(String [] args){
        Scanner scan = new Scanner(System.in);
        int v,e;
        String edge;
        String egdeVal[];
        System.err.println("Podaj liczbe wierzcholkow");
        v = Integer.parseInt(scan.nextLine());
        System.err.println("Podaj liczbe krawedzi");
        e = Integer.parseInt(scan.nextLine());
        zad3 z = new zad3(v,e);
        while(e>0){
            edge = scan.nextLine();
            egdeVal = edge.split(" ");
            z.addEdge(Integer.parseInt(egdeVal[0]),Integer.parseInt(egdeVal[1]),Double.parseDouble(egdeVal[2]));
            e--;
        }
        if(args[0].equals("-k")){
            z.kruskal();
            z.print(1);
        }
        else if(args[0].equals("-p")){
            z.prim();
            z.print(2);
        }
    }
}
