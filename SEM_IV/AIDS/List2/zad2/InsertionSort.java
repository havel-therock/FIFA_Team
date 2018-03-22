
/**
 *
 * @author jakub
 */
public class InsertionSort {

    long totalTime;
    int swap;
    int nr;//Liczba porównań Σi od 1 do length-1 

    public int[] doInsertionSort(int[] input,int length, boolean gl) {
        nr = 0;
        swap = 0;
        int temp=0;
        if (gl) {
            long startTime = System.nanoTime();
            for (int i = 1; i < length; i++) {
                for (int j = i; j > 0; j--) {
                
                    nr++;
                    if (input[j] > input[j - 1]) {
                       swap++; //  System.out.println("swap");
                        temp = input[j];
                        input[j] = input[j - 1];
                        input[j - 1] = temp;
                    }
                }
            }
            long endTime = System.nanoTime();
            totalTime = endTime - startTime;
            return input;
        } else {
            long startTime = System.nanoTime();
            for (int i = 1; i < length; i++) {
                for (int j = i; j > 0; j--) {
                    nr++;
                      // System.out.println("Porównuję " + input[j] + " < " + input[j - 1]);
                    if (input[j] < input[j - 1]) {
                      //  System.out.println("swap");
                        swap++;
                        temp = input[j];
                        input[j] = input[j - 1];
                        input[j - 1] = temp;
                    }
                }
            }
            long endTime = System.nanoTime();
            totalTime = endTime - startTime;
            return input;
        }
    }
}
