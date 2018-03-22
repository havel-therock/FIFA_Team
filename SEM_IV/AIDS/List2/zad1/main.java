import java.util.Scanner;

/**
 *
 * @author Jakub Duda
 */
public class main {

    /**
     * @param args the command line arguments
     */
    static int[] array;
    static int[] tempMergArr;
    static int length;

    public static void main(String[] args) {
        getInput();
        if (args[0].equals("--type") && args[2].equals("--comp")) {
//-----------------------INSERTION SORT--------------------------    
            if (args[1].equals("insert")) {
                InsertionSort is = new InsertionSort();
                if (args[3].equals(">=")) {
                    System.out.println("Sortowanie InsertionSort malejąco");
                    is.doInsertionSort(array, length, true);

                } else if (args[3].equals("<=")) {
                    System.out.println("Sortowanie InsertionSort rosnąco");
                    is.doInsertionSort(array, length, false);

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
                System.out.println("Liczba przestawień " + is.swap);
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
                System.out.println("Liczba przestawień " + ms.swap);

                //-----------------------QUICK SORT--------------------------                   
            } else if (args[1].equals("quick")) {
                QuickSort qs = new QuickSort();
                if (args[3].equals(">=")) {
                    qs.sort(array, length, true);
                } else if (args[3].equals("<=")) {
                    qs.sort(array, length, false);
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
                System.out.println("Liczba przestawień " + qs.swap);
            } else {
                System.out.println("Nie prawidłowy parm type wybierz insert|merge|quick");
                 System.exit(length);
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
        if(length<1){
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

