package technologie2;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.Random;
import java.util.Iterator;
import org.jgrapht.alg.ConnectivityInspector;
import org.jgrapht.alg.DijkstraShortestPath;
import org.jgrapht.graph.*;

public final class Technologie2 {

    public static ConnectivityInspector<Integer, DefaultWeightedEdge> connectivityInspector;
    public static SimpleWeightedGraph<Integer, DefaultWeightedEdge> G;
    public static DefaultWeightedEdge[][] E;
    public static int[] V;
    public static double[][] H;
    public static int numberOfVertices = 10;
    public static int numberOfEdges = 14;

    public static int[][] N;	//Intensity matrix (Macierz natężeń)
    public static int[][] C;	//Capacity matrix (Macierz przepustowości)
    public static int avgPackage = 2000; //AVARGE PACKAGE SIZE 
    public static int interwal = 1000;   //REPATS 
    public static double p = 0.70;      //PROPABILITY 
    public static double T_max = 5E-5; //MAXIMUM DEALY

    private Technologie2() {
    }

    public static void main(String[] args) {
     
        if (args.length < 1) {
            V = new int[numberOfVertices];
            //Exercise A
            G = createWeightedGraph();
            C = createCapacityMatrix();
            N = createIntensityMatrix();
        } else if (args[0].equals("--load")) {
            loadGraph("data.txt");
        }
        //Exercise B
        traverseGraph(G);

        double T = delay(G) * 10E5;
        System.out.printf("T = %.2f ms\n", T);

        //Exercise C
        double reliabity = test(interwal, p, T_max);
        System.out.println("Niezawodność = " + reliabity);
    }

    private static void loadGraph(String source) {
        G = new SimpleWeightedGraph<Integer, DefaultWeightedEdge>(DefaultWeightedEdge.class);
        FileReader fr = null;
        String linia = "";

        // OTWIERANIE PLIKU:
        try {
            fr = new FileReader(source);
        } catch (FileNotFoundException e) {
            System.out.println("BŁĄD PRZY OTWIERANIU PLIKU!");
            System.exit(1);
        }

        BufferedReader bfr = new BufferedReader(fr);
        int numberOfVertices = 0;
        // ODCZYT KOLEJNYCH LINII Z PLIKU:
        try {
            //Odczytanie liczby wierzchołków
            numberOfVertices = Integer.parseInt(bfr.readLine());
            V = new int[numberOfVertices];
            C = new int[numberOfVertices][numberOfVertices];
            N = new int[numberOfVertices][numberOfVertices];
            for (int i = 0; i < numberOfVertices; i++) {
                G.addVertex(i + 1);
            }
            //Wczytywanie krawędzi 
            linia = bfr.readLine();
            while (linia != null && !linia.equals("C")) {
                String[] edge = new String[2];
                edge = linia.split("-");
                G.addEdge(Integer.parseInt(edge[0]), Integer.parseInt(edge[1]));
                linia = bfr.readLine();
            }
            //Wczytywanie wierzchołków 
            linia = bfr.readLine();
            while (linia != null && !linia.equals("N")) {
                String[] capacity = new String[3];
                capacity = linia.split("-");
                C[Integer.parseInt(capacity[0]) - 1][Integer.parseInt(capacity[1]) - 1] = Integer.parseInt(capacity[2]);
                linia = bfr.readLine();
            }
            //Wczytywanie macierzy natężeń 
            linia = bfr.readLine();
            while (linia != null) {
                String[] intensity = new String[3];
                intensity = linia.split("-");
                N[Integer.parseInt(intensity[0]) - 1][Integer.parseInt(intensity[1]) - 1] = Integer.parseInt(intensity[2]);
                linia = bfr.readLine();
            }
        } catch (IOException e) {
            System.err.println("BŁĄD ODCZYTU Z PLIKU!");
            System.exit(2);
        }

        // ZAMYKANIE PLIKU
        try {
            fr.close();
        } catch (IOException e) {
            System.err.println("BŁĄD PRZY ZAMYKANIU PLIKU!");
            System.exit(3);
        }
    }

    private static int v(int i) {
        return V[i - 1];
    }

    private static int a(DefaultWeightedEdge e) {
        int v1 = G.getEdgeSource(e);
        int v2 = G.getEdgeTarget(e);
        int a = N[v1 - 1][v2 - 1];
        return a;
    }

    private static double c(DefaultWeightedEdge e) {
        int v1 = G.getEdgeSource(e);
        int v2 = G.getEdgeTarget(e);
        double c = C[v1 - 1][v2 - 1];
        return c;
    }

    //Testowanie nierozspójności sieci 
    private static double test(double numberOfSimulations, double p, double T_max) {
        double failedSimulations = 0;
        Random random = new Random();

        for (int i = 0; i < numberOfSimulations; i++) {
            SimpleWeightedGraph<Integer, DefaultWeightedEdge> G_prim = new SimpleWeightedGraph<Integer, DefaultWeightedEdge>(DefaultWeightedEdge.class);
            G_prim = (SimpleWeightedGraph<Integer, DefaultWeightedEdge>) G.clone(); //KOPIOWANIE GRAFU 
            Object[] edgesArray = G_prim.edgeSet().toArray();
            for (int j = 0; j < edgesArray.length; j++) { //PRZECHODZENIE PO WSZYSTKICH KRAWĘDZIACH 
                DefaultWeightedEdge edge = (DefaultWeightedEdge) edgesArray[j];
                if (random.nextFloat() > p) {
                    G_prim.removeEdge(edge); //USUWANIE KRAWEDZI
                }
            }
            connectivityInspector = new ConnectivityInspector<Integer, DefaultWeightedEdge>(G_prim);
            if (connectivityInspector.isGraphConnected()) { //SPRAWDZANIE SPOJNOŚĆI GRAFU 
                if (traverseGraph(G_prim)) { //SPRAWDZANIE CZY PRZEPUSTOWOŚĆ JEST WIĘKSZA NIŻ NATĘŻENIE 
                    double T = delay(G_prim); //OBLICZNAIE OPÓŹNIENIA
                    if (T > T_max) {
                        failedSimulations++;
                    }
                } else {
                    failedSimulations++;
                }
            } else {
                failedSimulations++;
            }
        }
        double proportion = (numberOfSimulations - failedSimulations) / numberOfSimulations;
        System.out.println("Udane symulacje = " + (numberOfSimulations - failedSimulations) + " | Wszystkie symulacje = " + numberOfSimulations);
        return proportion;

    }

    //TESTOWANIE Przepływu 
    private static boolean traverseGraph(SimpleWeightedGraph G_prim) {
        for (int i = 0; i < numberOfVertices; i++) {
            for (int j = 0; j < numberOfVertices; j++) {
                if (N[i][j] != 0) {
                    DijkstraShortestPath<Integer, DefaultWeightedEdge> dijkstraPath = new DijkstraShortestPath<Integer, DefaultWeightedEdge>(G, i + 1, j + 1); //ZNAJDOWANIE NAJKRÓTSZEJ ŚCIEŻKI 
                    for (java.util.Iterator<DefaultWeightedEdge> iterator = dijkstraPath.getPathEdgeList().iterator(); iterator.hasNext();) { //PRZEJSCIE PO WSZYSTKICH KRAWĘDZIACH NAJKRÓTSZEJ DROGI
                        DefaultWeightedEdge edge = iterator.next();
                        double weight = G_prim.getEdgeWeight(edge);
                        G_prim.setEdgeWeight(edge, weight + N[i][j]); //DODAWANIE NATĘŻENIA 
                        int v1 = (int) G_prim.getEdgeSource(edge);
                        int v2 = (int) G_prim.getEdgeTarget(edge);
                        if (G_prim.getEdgeWeight(edge)*avgPackage > C[v1 - 1][v2 - 1]) { //SPRAWDZANIE CZY PRZEPŁYW NIE JEST WIĘKSZY OD PRZEPUSTOWOŚCI 
                            System.out.println("Przepływ wiekszy od przepustowości - PORAŻKA");
                            return false;

                        }
                    }
                }
            }
        }
        return true;
    }

    // OBLICZANIE OPÓŹNIENIA 
    private static double delay(SimpleWeightedGraph<Integer, DefaultWeightedEdge> G_prim) {
        double T = 0, n = 0, SUM_e = 0;
        for (int i = 0; i < numberOfVertices; i++) {
            for (int j = 0; j < numberOfVertices; j++) {
                n += N[i][j]; //SUMOWANIE WSZYSTKICH ELEMENTÓW MACIERZY NATĘŻĘŃ 
            }
        }

        for (Iterator<DefaultWeightedEdge> i = G_prim.edgeSet().iterator(); i.hasNext();) {
            DefaultWeightedEdge edge = i.next();
            
            if (((c(edge) / avgPackage) - a(edge)) > 0) {
                SUM_e += a(edge) / ((c(edge) / avgPackage) - a(edge));
            } else {
                return 0;
            }

        }
        T = 1 / n * SUM_e;

        return T;
    }

    //TWORZENIE GRAFU 
    private static SimpleWeightedGraph<Integer, DefaultWeightedEdge> createWeightedGraph() {

        G = new SimpleWeightedGraph<Integer, DefaultWeightedEdge>(DefaultWeightedEdge.class);

        for (int i = 0; i < 10; i++) {
            V[i] = i + 1;
            G.addVertex(v(i + 1));
        }

        G.addEdge(v(1), v(2));
        G.addEdge(v(2), v(3));
        G.addEdge(v(3), v(4));
        G.addEdge(v(4), v(5));
        G.addEdge(v(5), v(1));
        G.addEdge(v(6), v(1));
        G.addEdge(v(2), v(7));
        G.addEdge(v(3), v(8));
        G.addEdge(v(4), v(9));
        G.addEdge(v(5), v(10));
        G.addEdge(v(6), v(8));
        G.addEdge(v(6), v(9));
        G.addEdge(v(7), v(9));
        G.addEdge(v(7), v(10));
        G.addEdge(v(10), v(8));

        return G;
    }

    //TWORZENIE MACIERZY PRZEPUSTOWOSCI 
    private static int[][] createCapacityMatrix() {
        C = new int[numberOfVertices][numberOfVertices];
        //Setting all values to 0
        for (int[] row : C) {
            Arrays.fill(row, 0);
        }
        //Row 1
        C[0][1] = 1000000000;	//1 Gb/s
        C[0][5] = 1000000000;
        C[0][4] = 10000000;
        //Row 2
        C[1][0] = 1000000000;
        C[1][2] = 1000000000;
        C[1][6] = 10000000;    //10 Mb/s
        //Row 3
        C[2][1] = 1000000000;
        C[2][3] = 1000000000;
        C[2][7] = 10000000;
        //Row 4
        C[3][2] = 1000000000;
        C[3][4] = 1000000000;
        C[3][8] = 100000000;
        //Row 5
        C[4][3] = 1000000000;
        C[4][0] = 1000000000;
        C[4][9] = 10000000;
        //Row 6
        C[5][0] = 1000000000;
        C[5][8] = 1000000000;
        C[5][7] = 1000000;
        //Row 7
        C[6][1] = 1000000000;
        C[6][8] = 1000000000;
        C[6][9] = 10000000;
        //Row 8
        C[7][2] = 1000000000;
        C[7][5] = 1000000000;
        C[7][9] = 1000000;
        //Row 9
        C[8][3] = 1000000000;
        C[8][6] = 1000000000;
        C[8][5] = 10000000;
        //Row 10
        C[9][4] = 1000000000;
        C[9][6] = 1000000000;
        C[9][7] = 10000000;

        return C;
    }

    //TWORZENIE MACIERZY NATĘŻEŃ 
    private static int[][] createIntensityMatrix() {
        N = new int[numberOfVertices][numberOfVertices];
        Random ran = new Random();
        for (int i = 0; i < numberOfVertices; i++) {
            for (int j = 0; j < numberOfVertices; j++) {
                N[i][j] = ran.nextInt(j) + 10;
            }
        }
        for (int i = 0; i < numberOfVertices; i++) {
            N[i][i] = 0;
        }
        return N;
    }
}
