import javax.swing.JFrame;
import org.apache.commons.collections15.FactoryUtils;
import edu.uci.ics.jung.algorithms.shortestpath.*;
import edu.uci.ics.jung.algorithms.layout.*;
import edu.uci.ics.jung.graph.*;
import edu.uci.ics.jung.visualization.*;
import edu.uci.ics.jung.io.*;
import java.awt.*;
import java.io.IOException;
import java.util.Random;
import java.util.Scanner;

public class MyGraph extends JFrame{

	private static final long serialVersionUID = 1L;

	//wyœwietla graf w oknie
	public void show (Graph<Integer, Object> g){
	    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	    
	    VisualizationViewer<Integer,String> vv = new VisualizationViewer<Integer,String>(new CircleLayout(g), new Dimension (300,300));
	    getContentPane().add(vv);
	 
	    pack();
	    setSize (new Dimension (400,400));
	    setVisible(true);
	}
	
	//tworzy graf
	public static Graph<Integer, Object> getGraph() throws IOException{
		PajekNetReader pnr = new PajekNetReader(FactoryUtils.instantiateFactory(Object.class));
		Graph<Integer, Object> g = new UndirectedSparseGraph<Integer, Object>();
		pnr.load("graf.txt", g);
		/**Graph<Integer, String> g = new SparseGraph<Integer, String>();
		for(int i=1;i<=20;i++) {
			g.addVertex(i);
		}
		for(int j=1;j<=19;j++) {
			g.addEdge("e"+j,j,j+1);
		}*/
	    return g;
	}
	
	public boolean cohesion(Graph<Integer, Object> g) {
		DijkstraShortestPath<Integer, Object> sp = new DijkstraShortestPath<>(g);
		
		for(int i=0;i<g.getVertexCount();i++) {
			if(g.degree(i)==0) {
				return false;
			}
			if (sp.getDistance(1, i) == null) {
				return false;
			}
		}
		return true;
	}
	
	public boolean reliabilityTest(double[][] edgeP,Graph<Integer, Object> cg,Object[] edges) {
		double x;
		
		for(int i=0;i<edges.length;i++) {
			x = new Random().nextDouble();
			Object[] m = cg.getIncidentVertices(edges[i]).toArray();
			if(x>edgeP[(int)m[0]][(int)m[1]]) {
				cg.removeEdge(edges[i]);
			}
		}
		if(cohesion(cg)) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public void extraEdge(Graph<Integer, Object> g, int v1, int v2) {
		PajekNetReader pnr = new PajekNetReader(FactoryUtils.instantiateFactory(Object.class));
		g.addEdge(pnr,v1,v2);
	}
	
	public void randEdge(Graph<Integer, Object> g, int v1, int v2) {
		PajekNetReader pnr = new PajekNetReader(FactoryUtils.instantiateFactory(Object.class));
		g.addEdge(pnr,v1,v2);
	}
	
	@SuppressWarnings("resource")
	public static void main(String[] args){
		MyGraph mg = new MyGraph();
		Scanner scan;
		scan = new Scanner(System.in);
		String s;
		double succes=0,fails=0,nrTry=0;
		double probability;
		double [][]edgeProb = new double[50][50];
		String []vals = new String[3];
		
		//tworzenie grafu
		Graph<Integer, Object> g = new SparseGraph<Integer, Object>();
		Graph<Integer, Object> cg = new SparseGraph<Integer, Object>();
		try {
			g = getGraph();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Object[] mEdges = g.getEdges().toArray();
		
		//tworzenie macierzy z prawdopodobienstwem istnienia polaczenia
		for(int i=0;i<g.getVertexCount();i++) {
			for(int j=0;j<g.getVertexCount();j++) {
				if(g.isNeighbor(i,j)) {
					edgeProb[i][j] = 0.95;
					edgeProb[j][i] = 0.95;
				}
				else {
					edgeProb[i][j] = 0;
					edgeProb[j][i] = 0;
				}
			}
		}
	    
		//obs³uga programu
		while(true) {
			System.out.println("1-pokaz graf, 2-sprawdz spojnosc grafu, 3-testuj niezawodnosc sieci,\n"
					+ "4-dodaj krawedz,  5-dodaj losowa krawedz, 0-zakoncz dzialanie");
			s = scan.nextLine();
			switch(s) {
			case "1":
				mg.show(g);
				break;
			case "2":
				if(mg.cohesion(g)) {
					System.out.println("graf jest spójny");
				}
				else {
					System.out.println("graf nie jest spójny");
				}
				break;
			case "3":
				nrTry=0;
				fails=0;
				succes=0;
				for(int i=0;i<10000;i++) {
					nrTry++;
					for (Integer v : g.getVertices()) {
						cg.addVertex(v);
					}
					for (Object e : g.getEdges()) {
						cg.addEdge(e, g.getIncidentVertices(e));
					}
					if(mg.reliabilityTest(edgeProb,cg,mEdges)) {
						succes++;
					}
					else {
						fails++;
					}
				}
				probability = succes/nrTry;
				System.out.println("wykonano "+nrTry+" prob");
				System.out.println("sukcesem zakonczylo sie: "+succes);
				System.out.println("prawdowpodobienstwo nizawodnosci sieci wynosi: "+probability);
				break;
			case "4":
				s = scan.nextLine();
				vals = s.split(";");
				mg.extraEdge(g,Integer.parseInt(vals[0]),Integer.parseInt(vals[1]));
				edgeProb[Integer.parseInt(vals[0])][Integer.parseInt(vals[1])] = Double.parseDouble(vals[2]);
				edgeProb[Integer.parseInt(vals[1])][Integer.parseInt(vals[0])] = Double.parseDouble(vals[2]);
				mEdges = g.getEdges().toArray();
				break;
			case "5":
				s = scan.nextLine();
				int x,y;
				x = new Random().nextInt(g.getVertexCount());
				y = new Random().nextInt(g.getVertexCount());
				mg.randEdge(g,x,y);
				edgeProb[x][y] = Double.parseDouble(s);
				edgeProb[y][x] = Double.parseDouble(s);
				mEdges = g.getEdges().toArray();
				break;
			case "0":
				System.exit(0);
			}
		}
	}
}