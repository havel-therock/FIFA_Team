import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

public class Traverse {
	private static long beforeUsedMem;
	private static long afterUsedMem;
	private static long actualMemUsed;
	int vNumber;
	int eNumber;
	Edge [] edges;
	List<Edge> spanEdges;
	double weight;
	Pqueue q;
	List<Edge> []  adj;
	//double [][] weights;
	
	public Traverse(int vNumber, int eNumber) {
		this.vNumber=vNumber;
		this.eNumber=eNumber;
		this.edges=new Edge[eNumber];
		this.weight=0;
		this.q=new Pqueue(eNumber);
		this.spanEdges=new ArrayList<>();
		//this.weights=new double[eNumber][eNumber];
		this.adj = new List[vNumber];
	}
	
	public void addEdge(String string, String string2, String string3, int i) {
		int w1 = Integer.parseInt(string);
		int w2 = Integer.parseInt(string2);
		double p = Double.parseDouble(string3);
		
		//System.out.println(i + " " + eNumber + " " + w1 + " " + w2 + " " + vNumber);
		edges[i]=new Edge(w1-1,w2-1,p);
		q.insert(i, p);
		if(adj[w1-1]==null)
			adj[w1-1] = new ArrayList<>();
		adj[w1-1].add(new Edge(w1-1,w2-1,p));
		if(adj[w2-1]==null)
			adj[w2-1] = new ArrayList<>();
		adj[w2-1].add(new Edge(w2-1,w1-1,p));
		//weights[w1-1][w2-1]=p;
		//weights[w2-1][w1-1]=p;
	}
	
	public Edge findMinEdge(List<Edge> l,Boolean [] T){
		int size = l.size();
		if(size<1)
			return null;
		int z=0;
		while(z<size && T[l.get(z).v2]!=false){
			z++;
		}
		if(z>=size)
			return null;
		Edge counter=l.get(z);
		double temp;
		
		for(int i=z+1;i<l.size();i++){
			if(T[l.get(i).v2]==false){
				temp = l.get(i).w;
				if(temp<counter.w)
					counter= l.get(i);
			}
		}
		return counter;
	}
	
	public Edge findRandEdge(List<Edge> l,Boolean [] T){
		
		List<Edge> p = new ArrayList<>();
		int size = l.size();
		for(int i=0;i<size;i++)
			p.add(l.get(i));
		Random rand = new Random(); 
		int value = rand.nextInt(size);
		while(T[p.get(value).v2]!=false){
			p.remove(value);
			size--;
			value = rand.nextInt(size);
		}
		Edge counter=p.get(value);
		
		return counter;
	}
	
	public void doEulerAlgorithm() {
					
			SpanningTree Tree = new SpanningTree(vNumber, eNumber);
			Tree.edges=this.edges;
			Tree.adj=this.adj;
			Tree.q=this.q;
			Tree.doKruskalAlgorithm();
		//	for(int i=0;i<Tree.spanEdges.size();i++)
			//	System.out.println((Tree.spanEdges.get(i).v1+1) + " qqq " + (Tree.spanEdges.get(i).v2+1) + " " + Tree.spanEdges.get(i).w);
			this.adj = new List[vNumber];
			Edge ed;
			eNumber=Tree.spanEdges.size();
			for(int i=0;i<eNumber;i++){
				ed=Tree.spanEdges.get(i);
				if(adj[ed.v1]==null)
					adj[ed.v1] = new ArrayList<>();
				adj[ed.v1].add(new Edge(ed.v1,ed.v2,ed.w));
				if(adj[ed.v2]==null)
					adj[ed.v2] = new ArrayList<>();
				adj[ed.v2].add(new Edge(ed.v2,ed.v1,ed.w));
			}
			
			int w = Tree.spanEdges.get(0).v1;
			//System.out.println(Tree.spanEdges.size());
			findEuler(w, -1);
			System.out.println("Euler Algorytm ");
	}

	public void findEuler(int w,int bef){
		int i=0;
		while(i<adj[w].size()){
			Edge edge = adj[w].get(i);
			if(edge.v2!=bef){
				weight+=edge.w;
				spanEdges.add(edge);
				//System.out.println(w + "  " + edge.v2);
				findEuler(edge.v2,w);
				spanEdges.add(adj[edge.v2].get(0));
				adj[w].remove(i);
			} else i++;
		}
	}
	public void doGreedyAlgorithm() {
	//	for(int i = 0;i<vNumber;i++)
	//		System.out.println(adj[i].size() + " " + i);
		int w = edges[q.top()].v1;
		Boolean [] visit = new Boolean[vNumber];
		for(int i=0;i<vNumber;i++)
			visit[i]=false;
		visit[w]=true;
		int  n,before;
		
		for(int i=0;i<vNumber-1;i++){
			before = w;
		//	System.out.println(w + " " + adj[w].size() + " " + adj[w].get(0).v2 + " " + visit[adj[w].get(0).v2]);
			Edge x = findMinEdge(adj[before],visit);
			w = x.v2;
			
			spanEdges.add(new Edge(before, w, x.w));
			weight+=x.w;
			visit[w]=true;
		}	
		System.out.println("Greedy Algorytm ");
	}

	public void doRandomAlgorithm() {
		int w = edges[q.top()].v1;
		Boolean [] visit = new Boolean[vNumber];
		for(int i=0;i<vNumber;i++)
			visit[i]=false;
		visit[w]=true;
		int  n,before;
		
		for(int i=0;i<vNumber-1;i++){
			before = w;
			Edge x = findRandEdge(adj[before],visit);
			w = x.v2;
			
			spanEdges.add(new Edge(before, w, x.w));
			weight+=x.w;
			visit[w]=true;
		}
		System.out.println("Random Algorytgm ");
		
	}

	public void showOutput(long M, long  T) {
		for(int i=0;i<spanEdges.size();i++)
			System.err.println((spanEdges.get(i).v1+1) + " " + (spanEdges.get(i).v2+1) + " " + spanEdges.get(i).w);
		System.out.println(spanEdges.size() + " " + weight + " " + M + " " + T + " ");
		weight=0;
		spanEdges.clear();
	}
	
	public static void test() {
		int counter=0;
		Random rand = new Random();
		for(int i=5;i<501;i*=10){
			Traverse struct = new Traverse(i,((i*(i-1))/2));
			for(int z=1;z<=i;z++)
				for(int g=z+1;g<=i;g++){
					int waga = rand.nextInt(60)+ 60;
					struct.addEdge(Integer.toString(z),Integer.toString(g),Integer.toString(waga),counter);
					counter++;
				}
			counter=0;
			doAlgorythm(struct);
		}
	}
	
	public static void main(String[] args) {
		//test();
		
		System.out.println("Hello, write the number of vertexs");
	 	Scanner reader = new Scanner(System.in);
		int vNumber = reader.nextInt();
		int eNumber = (vNumber*(vNumber-1))/2;
		System.out.println("write your edges in that form : 'u v w' u,v-vertexs w - weight");
		Traverse struct = new Traverse(vNumber,eNumber);
		String[] command;
		command = reader.nextLine().split(" ");
		for (int i=0;i<eNumber;i++){
			command = reader.nextLine().split(" ");
			struct.addEdge(command[0],command[1],command[2],i);
		}
		
		doAlgorythm(struct);
	}

	private static void doAlgorythm(Traverse struct) {
		beforeUsedMem = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
		long sTime = System.currentTimeMillis();
		struct.doRandomAlgorithm();
		long eTime = System.currentTimeMillis();
		afterUsedMem = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
		actualMemUsed = afterUsedMem - beforeUsedMem;
		long tTime = eTime - sTime;
		struct.showOutput(actualMemUsed, tTime);
		
		beforeUsedMem = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
		sTime = System.currentTimeMillis();
		struct.doGreedyAlgorithm();
		eTime = System.currentTimeMillis();
		afterUsedMem = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
		actualMemUsed = afterUsedMem - beforeUsedMem;
		tTime = eTime - sTime;
		struct.showOutput(actualMemUsed, tTime);
      
		beforeUsedMem = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
		sTime = System.currentTimeMillis();
		struct.doEulerAlgorithm();
		eTime = System.currentTimeMillis();
		afterUsedMem = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
		actualMemUsed = afterUsedMem - beforeUsedMem;
		tTime = eTime - sTime;
		struct.showOutput(actualMemUsed, tTime);
	}
	

}
