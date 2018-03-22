
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Random;
import java.util.Scanner;

/**
 *
 * @author jakub
 */
public class AISD22 {

    /**
     * @param args the command line arguments
     */
    static int[] array;
    static int[] tempMergArr;
    static int length;
    static String filename;
    static int k;
    static PrintWriter file;

    public static void main(String[] args) {
      
        if (args[0].equals("--type") && args[2].equals("--comp")) {
              getInput();
//-----------------------INSERTION SORT--------------------------    
            if (args[1].equals("insert")) {
                InsertionSort is = new InsertionSort();
                if (args[3].equals(">=")) {
                    System.out.println("Sortowanie InsertionSort malejąco");
                    is.doInsertionSort(array,array.length,true);

                } else if (args[3].equals("<=")) {
                    System.out.println("Sortowanie InsertionSort rosnąco");
                    is.doInsertionSort(array,array.length, false);

                } else {
                    System.out.println("Nieprawidłowy parm comp podaj >= | <=");
                    System.exit(length);
                }
                System.out.print("Posortowana tablica: ");
                for (int i : array) {
                    System.out.print(i);
                    System.out.print(", ");
                }
                System.out.println("\nCzas= " + is.totalTime + "ns");
                System.out.println("Liczba porównań " + is.nr);
                //-----------------------MERGE SORT--------------------------                   
            } else if (args[1].equals("merge")) {
                MergeSort ms = new MergeSort();
                if (args[3].equals(">=")) {
                    ms.sort(array, true);
                } else if (args[3].equals("<=")) {
                    ms.sort(array, false);
                } else {
                    System.out.println("Nieprawidłowy parm comp podaj >= | <=");
                    System.exit(length);
                }
                System.out.print("Posortowana tablica: ");
                for (int i : array) {
                    System.out.print(i);
                    System.out.print(" ");
                }
                System.out.println("\nCzas-> " + ms.totalTime + "ns");
                System.out.println("Liczba porównań-> " + ms.nr);

                //-----------------------QUICK SORT--------------------------                   
            } else if (args[1].equals("quick")) {
                QuickSort qs = new QuickSort();
                if (args[3].equals(">=")) {
                    qs.sort(array, true);
                } else if (args[3].equals("<=")) {
                    qs.sort(array, false);
                } else {
                    System.out.println("Nieprawidłowy parm comp podaj >= | <=");
                    System.exit(length);
                }
                System.out.print("Posortowana tablica: ");
                for (int i : array) {
                    System.out.print(i);
                    System.out.print(" ");
                }
                System.out.println("\nCzas-> " + qs.totalTime + "ns");
                System.out.println("Liczba porównań-> " + qs.nr);
            } else {
                System.out.println("Nie prawidłowy parm type wybierz insert|merge|quick");
                System.exit(length);
            }
        } else if (args[0].equals("--stat")) {
            filename = args[1];
            try {
                file = new PrintWriter(filename);
            } catch (FileNotFoundException ex) {

            }
            k = Integer.parseInt(args[2]);
            file.println("\n------------Statystyki----------------\n");

            for (int i = 100; i < 10000; i = i+100) {
                file.println("Dla danych rozmiaru n=" + i);
                array = new int[i];
                Random ran = new Random();
               
                for (int l = 0; l < k; l++) {
                     for (int j = 0; j < i; j++) {
                     array[j] =ran.nextInt();
                }
                file.println("\n\n----------Powtórzenie: "+(l+1)+"---------\n\n");
                int[] arrayQS = array;
                int[] arrayIS = array;
                int[] arrayMS = array;
                
                 InsertionSort is = new InsertionSort();
                is.doInsertionSort(arrayIS,arrayIS.length, false);
                file.println("\n------------Insertion Sort------------");
                file.println("Liczba porównań: " + is.nr);
                file.println("Liczba przestawień: " + is.swap);
                file.println("Czas działania: " + is.totalTime+"ns");
                
                
                QuickSort qs = new QuickSort();
                qs.sort(arrayQS, false);
                file.println("\n------------Quick Sort----------------");
                file.println("Liczba porównań: " + qs.nr);
                file.println("Liczba przestawień: " + qs.swap);
                file.println("Czas działania: " + qs.totalTime+"ns");
               
                MergeSort ms = new MergeSort();
                ms.sort(arrayMS, false);
                file.println("\n------------Merge Sort----------------");
                file.println("Liczba porównań: " + ms.nr);
                file.println("Liczba przestawień: " + ms.swap);
                file.println("Czas działania: " + ms.totalTime+"ns");
            }
            file.println("\n\n======================================\n\n");
            }

        } else {
            System.out.println("Błąd podaj parametry --type i --comp");
            System.exit(length);
        }

    }

    public static void getInput() {
        Scanner reader = new Scanner(System.in);
        System.out.println("Podaj rozmiar tablicy");
        length = reader.nextInt();
        if (length < 1) {
            System.out.println("Idioto odporność !!!");
            System.exit(length);

        }
        array = new int[length];
        System.out.println("Podaj tablicę");
        for (int i = 0; i < length; i++) {
            array[i] = reader.nextInt();
        }
        System.out.println("l: " + length + " s: " + array[2]);
    }
}
