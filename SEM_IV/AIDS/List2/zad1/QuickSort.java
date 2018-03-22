/**
 *
 * @author jakub
 */
public class QuickSort {

    private int[] array;
    private int length;
    long totalTime;
    int nr;
    int swap;

    public void sort(int[] inputArr, int length, boolean gl) {

        nr = 0;
        swap = 0;
        this.array = inputArr;
        this.length = length;
        long startTime = System.nanoTime();
        if (gl) {
            quickSortGT(0, this.length - 1);
        } else {
            quickSortLT(0, this.length - 1);
        }
        long endTime = System.nanoTime();
        totalTime = endTime - startTime;
    }

    private void quickSortGT(int lowerIndex, int higherIndex) {

        int i = lowerIndex;
        int j = higherIndex;
        // calculate pivot number, I am taking pivot as middle index number
        int pivot = array[lowerIndex + (higherIndex - lowerIndex) / 2];
        // Divide into two arrays
        System.out.println("Porównuję " + i + " z " + j);
        nr++;
        //nope
        while (i <= j) {
            System.out.println("Porównuję " + array[i] + " z " + pivot);
            nr++;
            while (array[i] > pivot) {
                i++;
            }
            System.out.println("Porównuję " + array[j] + " z " + pivot);
            nr++;
            while (array[j] < pivot) {
                j--;
            }
            System.out.println("Porównuję " + i + " z " + j);
            nr++;
            //nope
            if (i <= j) {
                exchangeNumbers(i, j);
                //move index to next position on both sides
                i++;
                j--;
            }
        }
        // call quickSort() method recursively
        System.out.println("Porównuję " + lowerIndex + " z " + j);
        nr++;
        if (lowerIndex < j) {
            quickSortGT(lowerIndex, j);
        }
        System.out.println("Porównuję " + higherIndex + " z " + i);
        nr++;
        if (i < higherIndex) {
            quickSortGT(i, higherIndex);
        }
    }

    private void quickSortLT(int lowerIndex, int higherIndex) {

        int i = lowerIndex;
        int j = higherIndex;
        // calculate pivot number, I am taking pivot as middle index number
        int pivot = array[lowerIndex + (higherIndex - lowerIndex) / 2];
        // Divide into two arrays
        System.out.println("Porównuję " + i + " z " + j);
        nr++;
        //nope
        while (i <= j) {
            System.out.println("Porównuję " + array[i] + " z " + pivot);
            nr++;
            while (array[i] < pivot) {
                i++;
            }
            System.out.println("Porównuję " + array[j] + " z " + pivot);
            nr++;
            while (array[j] > pivot) {
                j--;
            }
            System.out.println("Porównuję " + i + " z " + j);
            nr++;
            //nope
            if (i <= j) {
                exchangeNumbers(i, j);
                //move index to next position on both sides
                i++;
                j--;
            }
        }
        // call quickSort() method recursively
        System.out.println("Porównuję " + lowerIndex + " z " + j);
        nr++;
        if (lowerIndex < j) {
            quickSortLT(lowerIndex, j);
        }
        System.out.println("Porównuję " + higherIndex + " z " + i);
        nr++;
        if (i < higherIndex) {
            quickSortLT(i, higherIndex);
        }
    }

    private void exchangeNumbers(int i, int j) {
        System.out.println("Zamieniam " + i + " i " + j);
        int temp = array[i];
        array[i] = array[j];
        array[j] = temp;
        swap++;
    }
}

