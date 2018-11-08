import java.util.Scanner;

public class Dijkstra {
    int verticesNum;
    int edgeNum;
    double edgeWeight[][];
    double dist[];
    int prev[];
    double infinity = Double.POSITIVE_INFINITY;
    int first;

    Dijkstra(int verticesNum,int edgeNum){
        this.verticesNum = verticesNum;
        this.edgeNum = edgeNum;
        this.edgeWeight = new  double[verticesNum][verticesNum];
        this.dist = new double[verticesNum];
        this.prev = new int[verticesNum];
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
    }

    public void doAlgorithm(int s){
        this.first = s;
        for(int i=0;i<verticesNum;i++){
            dist[i] = infinity;
            prev[i] = -1;
        }
        dist[s] = 0;
        PriorityQueue pq = new PriorityQueue(edgeNum);
        for(int i=0;i<verticesNum;i++){
            pq.insert(i,dist[i]);
        }
        while(pq.empty()!=1){
            int u = pq.popInt();
            for(int i=0;i<verticesNum;i++){
                if(edgeWeight[u][i]>-1){
                    if(dist[i]>dist[u]+edgeWeight[u][i]){
                        dist[i] = dist[u]+edgeWeight[u][i];
                        prev[i] = u;
                        pq.priority(i,dist[i]);
                    }
                }
            }
        }
    }

    public void addEdge(int u,int v,double w){
        this.edgeWeight[u][v] = w;
    }

    public void read(){
        int tmp;
        for(int i=0;i<verticesNum;i++){
            System.out.println(i+","+dist[i]);
        }
        for(int i=0;i<verticesNum;i++){
            System.err.print(i+","+dist[i]);
            tmp = i;
            while(prev[i]!=-1){
                System.err.print(" <-- "+prev[i]+","+dist[prev[i]]);
                i = prev[i];
            }
            i = tmp;
            System.err.println();
        }
    }

    public static void main(String [] args){
        int v,e,f;
        String edge;
        String egdeVal[];
        Scanner scan = new Scanner(System.in);
        System.err.println("Ilosc wierzcholkow");
        v = Integer.parseInt(scan.nextLine());
        System.err.println("Ilosc krawedzi");
        e = Integer.parseInt(scan.nextLine());
        Dijkstra d = new Dijkstra(v,e);
        while(e>0){
            edge = scan.nextLine();
            egdeVal = edge.split(" ");
            d.addEdge(Integer.parseInt(egdeVal[0]),Integer.parseInt(egdeVal[1]),Integer.parseInt(egdeVal[2]));
            e--;
        }
        System.err.println("wierzcholek startowy");
        f = Integer.parseInt(scan.nextLine());
        long millisActualTime = System.currentTimeMillis();
        d.doAlgorithm(f);
        long executionTime = System.currentTimeMillis() - millisActualTime;
        d.read();
        System.err.println("Czas wykonania: "+executionTime+"ms");
    }
}
