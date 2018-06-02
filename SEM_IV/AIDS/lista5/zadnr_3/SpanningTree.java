import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class SpanningTree {
	
	static Boolean kruskal;
	int vNumber;
	int eNumber;
	Edge [] edges;
	List<Edge> spanEdges;
	double weight;
	Pqueue q;
	List<Edge> []  adj;
	//double [][] weights;
	
	public void doKruskalAlgorithm(){
		Edge x;
		SetElements [] z = new SetElements[vNumber];
		for(int i=0;i<vNumber;i++){
			z[i] = new SetElements(i);
			Sets.makeSet(z[i]);
		}
		for(int i=0;i<eNumber-1;i++){
			x = edges[q.pop()];
			if(Sets.findSet(z[x.v1])!=Sets.findSet(z[x.v2])){
				spanEdges.add(x);
				weight+=x.w;
				Sets.UnionSets(z[x.v1], z[x.v2]);
			}
		}
	}
	
	public void doPrimAlgorithm(){
		Boolean [] v = new Boolean[vNumber];
		Edge [] edges = new Edge[eNumber];
		int counter=0;
		for(int i=0;i<vNumber;i++){
			v[i]=false;
		}
		Pqueue q = new Pqueue(eNumber);
		int w = 0;
		v[w]=true;
		for(int i=0;i<vNumber-1;i++){
			for(int z=0;z<adj[w].size();z++){
				int u = adj[w].get(z).v2;
				if(v[u]==false){
					edges[counter]=new Edge(w, u, adj[w].get(z).w);
					q.insert(counter, adj[w].get(z).w);
					counter++;
				}
			}
			Edge p = edges[q.pop()];
			while(v[p.v2]==true){
				p = edges[q.pop()];
			}
			spanEdges.add(p);
			v[p.v2]=true;
			w = p.v2;
			weight+=p.w;
		}
	}
	
	public void showOutput() {
		for(int i=0;i<spanEdges.size();i++)
			System.out.println((spanEdges.get(i).v1+1) + " " + (spanEdges.get(i).v2+1) + " " + spanEdges.get(i).w);
		System.out.println("WAGA : " + weight);
	
	}
	
	public SpanningTree(int vNumber, int eNumber) {
		this.vNumber=vNumber;
		this.eNumber=eNumber;
		this.edges=new Edge[eNumber];
		this.weight=0;
		this.q=new Pqueue(eNumber);
		this.spanEdges=new ArrayList<>();
		this.adj = new List[vNumber];
		//this.weights=new double[eNumber][eNumber];
		
	}
	
	public void addEdge(String string, String string2, String string3, int i) {
		int w1 = Integer.parseInt(string);
		int w2 = Integer.parseInt(string2);
		double p = Double.parseDouble(string3);
		
		if(adj[w1-1]==null)
			adj[w1-1] = new ArrayList<>();
		adj[w1-1].add(new Edge(w1-1,w2-1,p));
		if(adj[w2-1]==null)
			adj[w2-1] = new ArrayList<>();
		adj[w2-1].add(new Edge(w2-1,w1-1,p));
		edges[i]=new Edge(w1-1,w2-1,p);
		q.insert(i, p);
		//weights[w1-1][w2-1]=p;
		//weights[w2-1][w1-1]=p;
	}
	
	public static void load(String f) {
		//System.out.println("zz");
		BufferedReader abc;
		try {
			abc = new BufferedReader(new FileReader(f));
	
			String line;
			int vNumber =  Integer.parseInt(abc.readLine());
			int eNumber =  Integer.parseInt(abc.readLine());
			SpanningTree struct = new SpanningTree(vNumber,eNumber);
			String[] command;
			//command = reader.nextLine().split(" ");
			int counter=0;
			while((line = abc.readLine()) != null) {
				command = line.split(" ");
				if(command.length==3)
					struct.addEdge(command[0],command[1],command[2],counter);
				counter++;
			}
			doAlgorythm(struct);
			abc.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static void doAlgorythm(SpanningTree struct) {
		long sTime = System.currentTimeMillis();
		if(kruskal==true)
			struct.doKruskalAlgorithm();
		else
			struct.doPrimAlgorithm();
		long eTime = System.currentTimeMillis();
		long tTime = eTime - sTime;
		struct.showOutput();
		System.err.println("Time " + tTime);
	}
	
	public static void main(String[] args) {
	if(args.length==1)
			if(args[0].equals("-k"))
				kruskal=true;
			else if(args[0].equals("-p"))
				kruskal=false;
		if(kruskal==null){
			System.out.println("Write parameter '-p' or '-k' ");
			System.exit(0);
		}
			
			System.out.println("Hello, write the number of vertexs");
		 	Scanner reader = new Scanner(System.in);
			int vNumber = reader.nextInt();
			System.out.println("write the number of edges");
			int eNumber = reader.nextInt();
			System.out.println("write your edges in that form : 'u v w' u,v-vertexs w - weight");
			SpanningTree struct = new SpanningTree(vNumber,eNumber);
			String[] command;
			command = reader.nextLine().split(" ");
			for (int i=0;i<eNumber;i++){
				command = reader.nextLine().split(" ");
				struct.addEdge(command[0],command[1],command[2],i);
			}
			doAlgorythm(struct);
			
		//load("mst.in");
		
	 }
}

class Sets{
	public static void makeSet(SetElements elem){
		elem.up=elem;
		elem.rank=0;
	}
	
	public static SetElements findSet(SetElements elem){
		SetElements p = elem;
		while(p.up!=p){
			p = p.up;
		}
		return p;
	}
	
	public static void UnionSets(SetElements elem1,SetElements elem2){
		SetElements r1 = findSet(elem1);
		SetElements r2 = findSet(elem2);
		if(r1==r2)
			return;
		if(r1.rank>r2.rank)
			r2.up=r1;
		else
			r1.up=r2;
		if(r1.rank==r2.rank)
			r2.rank++;
	}
	
}

class SetElements{
	int v;
	int rank;
	SetElements up;
	public SetElements(int v) {
		this.v=v;
	}
}
