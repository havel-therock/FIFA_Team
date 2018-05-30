import java.util.ArrayList;
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
	double [][] weights;
	
	public Traverse(int vNumber, int eNumber) {
		this.vNumber=vNumber;
		this.eNumber=eNumber;
		this.edges=new Edge[eNumber];
		this.weight=0;
		this.q=new Pqueue(eNumber);
		this.spanEdges=new ArrayList<>();
		this.weights=new double[eNumber][eNumber];
	}
	
	public void addEdge(String string, String string2, String string3, int i) {
		int w1 = Integer.parseInt(string);
		int w2 = Integer.parseInt(string2);
		double p = Double.parseDouble(string3);
		
		//System.out.println(i + " " + eNumber + " " + w1 + " " + w2 + " " + vNumber);
		edges[i]=new Edge(w1-1,w2-1,p);
		q.insert(i, p);
		weights[w1-1][w2-1]=p;
		weights[w2-1][w1-1]=p;
	}
	
	public void doEulerAlgorithm() {
		// TODO Auto-generated method stub		
	}

	public void doGreedyAlgorithm() {
		int w = edges[q.top()].v1;
		
		int  n,before;
		List<Integer> list= new ArrayList<>();
		for(int i=0;i<vNumber;i++)
			list.add(i);
		list.remove(w);
		for(int i=0;i<vNumber-1;i++){
			before = w;
			int size=list.size();
			Pqueue q = new Pqueue(size);
			for(int g=0;g<size;g++)
				q.insert(g,weights[before][list.get(g)]);	
			n=q.pop();
			w = list.get(n);
			spanEdges.add(new Edge(before, w, weights[before][w]));
			weight+=weights[before][w];
			list.remove(n);
		}	
	}

	public void doRandomAlgorithm() {
		int w = edges[q.top()].v1;
		
		int  n,before;
		Random rand = new Random();
		List<Integer> list= new ArrayList<>();
		for(int i=0;i<vNumber;i++)
			list.add(i);
		list.remove(w);
		for(int i=0;i<vNumber-1;i++){
			n = rand.nextInt(list.size());
			before = w;
			w = list.get(n);
			spanEdges.add(new Edge(before, w, weights[before][w]));
			weight+=weights[before][w];
			list.remove(n);
		}
		
	}

	public void showOutput(long M, long  T) {
		//for(int i=0;i<spanEdges.size();i++)
			//System.err.println((spanEdges.get(i).v1+1) + " " + (spanEdges.get(i).v2+1) + " " + spanEdges.get(i).w);
		System.out.println(spanEdges.size() + " " + weight + " " + M + " " + T + " " +vNumber);
		weight=0;
		spanEdges.clear();
	}
	
	public static void test() {
		int counter=0;
		Random rand = new Random();
		for(int i=5;i<500001;i*=10){
			Traverse struct = new Traverse(i,((i*(i-1))/2));
			for(int z=1;z<=i;z++)
				for(int g=z+1;g<=i;g++){
					int waga = rand.nextInt(100)+ 60;
					struct.addEdge(Integer.toString(z),Integer.toString(g),Integer.toString(waga),counter);
					counter++;
				}
			counter=0;
			doAlgorythm(struct);
		}
	}
	
	public static void main(String[] args) {
		test();
		/*
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
		
		doAlgorythm(struct);*/
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
      /*
		beforeUsedMem = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
		sTime = System.currentTimeMillis();
		struct.doEulerAlgorithm();
		eTime = System.currentTimeMillis();
		afterUsedMem = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
		actualMemUsed = afterUsedMem - beforeUsedMem;
		tTime = eTime - sTime;
		struct.showOutput(actualMemUsed, tTime);*/
	}

}
