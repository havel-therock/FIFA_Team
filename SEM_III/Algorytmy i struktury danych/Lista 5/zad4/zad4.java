import java.util.Random;
import java.util.Scanner;

public class zad4 {
    int verticesNum;
    int edgeNum;
    double edgeWeight[][];
    int prevR[];
    int steps1=0,steps2=0,steps3=0;
    double w1=0,w2=0,w3=0;
    int m1=0,m2=0,m3=0;

    zad4(int verticesNum){
        this.verticesNum = verticesNum;
        this.edgeNum = (verticesNum*(verticesNum-1))/2;
        edgeWeight = new double[verticesNum][verticesNum];
        for(int i=0;i<verticesNum;i++){
            for(int j=0;j<verticesNum;j++){
                edgeWeight[i][j] = -1;
            }
        }
        prevR = new int[verticesNum];
        for(int i=0;i<verticesNum;i++){
            prevR[i] = -1;
        }
    }

    public void addEdge(int u,int v,double w){
        this.edgeWeight[u][v] = w;
        this.edgeWeight[v][u] = w;
    }

    public void mstFind(){
        int actual=0;
        int visitedNum=1;
        int visited[] = new int[verticesNum];
        int oneCalc=0;
        double treeEdge[][] = new double[verticesNum][verticesNum];
        zad3 z3 = new zad3(verticesNum,edgeNum);
        m3 = verticesNum*verticesNum+verticesNum+3;
        for(int i=0;i<verticesNum;i++){
            visited[i]=0;
            for(int j=0;j<verticesNum;j++){
                z3.edgeWeight[i][j] = edgeWeight[i][j];
                treeEdge[i][j] = -1;
            }
        }
        z3.prim();
        for (int i = 0; i < verticesNum; i++) {
            if (z3.prev[i] != -1) {
                treeEdge[i][z3.prev[i]] = 0;
                treeEdge[z3.prev[i]][i] = 0;
            }
        }
        while(oneCalc<verticesNum){
            visited[actual]=1;
            for (int i = 0; i < verticesNum; i++) {
                if(treeEdge[actual][i]>=0 && treeEdge[actual][i]<=2){
                    treeEdge[actual][i]++;
                    treeEdge[i][actual]++;
                    steps3++;
                    w3 = w3 + edgeWeight[i][actual];
                    actual = i;
                    if(treeEdge[actual][i]==1) {
                        visitedNum++;
                    }
                    break;
                }
            }
            oneCalc=0;
            for(int i=0;i<verticesNum;i++){
                if(visited[i]==1){
                    oneCalc++;
                }
            }
        }

    }

    public void smallestWeight(){
        PriorityQueue neigborhood;
        int visitedNum = 1;
        int actual = 0;
        int visited[] = new int[verticesNum];
        m2 = verticesNum+1+(verticesNum)*2;
        for(int i=0;i<verticesNum;i++){
            visited[i] = 0;
        }
        while(visitedNum<=verticesNum){
            visited[actual] = 1;
            neigborhood = new PriorityQueue(verticesNum);
            for(int i=0;i<verticesNum;i++){
                if(edgeWeight[actual][i]>-1 && actual!=i && visited[i]==0){
                    neigborhood.insert(i,edgeWeight[actual][i]);
                }
            }
            steps2++;
            int old = actual;
            actual = neigborhood.popInt();
            if(actual!=-1) {
                w2 = w2 + edgeWeight[old][actual];
            }
            visitedNum++;
        }
    }

    public void randomEdge(){
        int neighbors=0;
        int neigborhood[] = new int[verticesNum];
        int visitedNum = 1;
        int visited[] = new int[verticesNum];
        int actual = 0;
        int next;
        m1 = 2*verticesNum+2;
        Random rand = new Random();
        prevR[actual] = 0;
        for(int i=0;i<verticesNum;i++){
            visited[i] = 0;
        }
        while(visitedNum<verticesNum){
            neighbors=0;
            visited[actual]++;
            for(int i=0;i<verticesNum;i++){
                if(edgeWeight[actual][i]>-1 && actual!=i && visited[i]<10){
                    neigborhood[neighbors] = i;
                    neighbors++;
                }
            }
            if(neighbors==0){
                for(int i=0;i<verticesNum;i++){
                    if(edgeWeight[actual][i]>-1 && actual!=i){
                        neigborhood[neighbors] = i;
                        neighbors++;
                    }
                }
            }
            next = neigborhood[rand.nextInt(neighbors)];
            if(prevR[next]==-1){
                visitedNum++;
            }
            prevR[next] = actual;
            w1 = w1 + edgeWeight[actual][next];
            actual = next;
            steps1++;
        }

    }

    public static void main(String [] args){
        Scanner scan = new Scanner(System.in);
        int e;
        String edge;
        String egdeVal[];
        System.err.println("Podaj liczbe wierzcholkow");
        zad4 z = new zad4(Integer.parseInt(scan.nextLine()));
        e = z.edgeNum;
        while(e>0){
            edge = scan.nextLine();
            egdeVal = edge.split(" ");
            z.addEdge(Integer.parseInt(egdeVal[0]),Integer.parseInt(egdeVal[1]),Double.parseDouble(egdeVal[2]));
            e--;
        }
        long millisActualTime = System.currentTimeMillis();
        z.randomEdge();
        long executionTime = System.currentTimeMillis() - millisActualTime;
        System.out.println(z.steps1+" "+z.w1+" "+z.m1+" "+executionTime);
        millisActualTime = System.currentTimeMillis();
        z.smallestWeight();
        executionTime = System.currentTimeMillis() - millisActualTime;
        System.out.println(z.steps2+" "+z.w2+" "+z.m2+" "+executionTime);
        millisActualTime = System.currentTimeMillis();
        z.mstFind();
        executionTime = System.currentTimeMillis() - millisActualTime;
        System.out.println(z.steps3+" "+z.w3+" "+z.m3+" "+executionTime);
    }
}
