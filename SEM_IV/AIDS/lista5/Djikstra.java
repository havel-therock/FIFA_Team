
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;


public class Djikstra {

	
	int vNumber;
	int eNumber;
	int vStart;
	List<Integer> []  Adj;
	double [][] weights;
	int [] prev;
	double [] dist;
	
	public Djikstra(int vNumber, int eNumber) {
		this.vNumber=vNumber;
		this.eNumber=eNumber;
		this.Adj = new List[vNumber];
		this.weights=new double[eNumber][eNumber];
		this.prev=new int[vNumber];
		this.dist = new double[vNumber];
	}
	
	public void setStart(int vStart) {
		this.vStart=vStart-1;		
	}
	
	public void addEdge(String string, String string2, String string3, int i) {
		int w1 = Integer.parseInt(string);
		int w2 = Integer.parseInt(string2);
		double p = Double.parseDouble(string3);
		
		if(Adj[w1-1]==null)
			Adj[w1-1] = new ArrayList<>();
		Adj[w1-1].add(w2-1);
		weights[w1-1][w2-1]=p;
	}
	
	public void doDjikstraAlgorithm() {
		Boolean [] v = new Boolean[vNumber];
		int [] s = new int[vNumber];
		Pqueue q = new Pqueue(vNumber);
		for(int i=0;i<vNumber;i++){
			v[i]=false;
			q.insert(i,Integer.MAX_VALUE);
			dist[i]=Integer.MAX_VALUE;
			prev[i]=-1;
		}
		q.priority(vStart, 0);
		dist[0]=0;
		int u;
		int temp;
		double helper;
		while(q.empty()!=0){
			//q.print();
			u = q.pop();
			v[u]=true;
			for(int i =0;i<Adj[u].size();i++){
				temp = Adj[u].get(i);
				if(v[temp]==false){
					helper=dist[u]+weights[u][temp];
					if(helper<dist[temp]){
						q.priority(temp,helper);
						dist[temp]=helper;
						prev[temp]=u;
					}
				}
			}
				
			
		}
	}
	
	public void showOutput() {
		int q,w;
		for(int i=0;i<vNumber;i++){
			q=i;
			w=i;
			System.err.print("DROGA DLA V "+ (i+1) + " WAGA " + dist[i] + " ::: ");
			while(prev[q]!=-1){
				q=prev[q];
				System.err.print("V "+ (q+1) + " -- V " + (w+1) + " Wagi " + weights[q][w] + " ; ");
				w=q;
			}
			System.err.println();
		}
		for(int i=0;i<vNumber;i++)
			System.out.println((i+1) + " " + dist[i]);
	
	}
	
	public static void load(String f) {
		//System.out.println("zz");
		BufferedReader abc;
		try {
			abc = new BufferedReader(new FileReader(f));
			String text="";
	
			String line;
			int vNumber =  Integer.parseInt(abc.readLine());
			int eNumber =  Integer.parseInt(abc.readLine());
			Djikstra struct = new Djikstra(vNumber,eNumber);
			String[] command;
			//command = reader.nextLine().split(" ");
			while((line = abc.readLine()) != null) {
				command = line.split(" ");
				if(command.length==3)
					struct.addEdge(command[0],command[1],command[2],0);
				else{
					int vStart =  Integer.parseInt(command[0]);
					struct.setStart(vStart);
					doAlgorytm(struct);
					break;
				}
			}
			abc.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
			
			System.out.println("Hello, write the number of vertexs");
		 	Scanner reader = new Scanner(System.in);
			int vNumber = reader.nextInt();
			System.out.println("write the number of edges");
			int eNumber = reader.nextInt();
			System.out.println("write your edges in that form : 'u v w' u,v-vertexs w - weight");
			Djikstra struct = new Djikstra(vNumber,eNumber);
			String[] command;
			command = reader.nextLine().split(" ");
			for (int i=0;i<eNumber;i++){
				command = reader.nextLine().split(" ");
				struct.addEdge(command[0],command[1],command[2],i);
			}
			System.out.println("number of your start vertex : ");
			int vStart = reader.nextInt();
			struct.setStart(vStart);
			doAlgorytm(struct);
			
		//load("dijkstra2.in");
		
	 }

	private static void doAlgorytm(Djikstra struct) {
		long sTime = System.currentTimeMillis();
		struct.doDjikstraAlgorithm();
		long eTime = System.currentTimeMillis();
		long tTime = eTime - sTime;
		struct.showOutput();
		System.err.println("Time " + tTime);
	}

}
