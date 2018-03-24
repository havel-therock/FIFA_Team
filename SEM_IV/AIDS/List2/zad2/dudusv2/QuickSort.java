
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

    public void sort(int[] inputArr, boolean gl) {
        nr = 0;
        swap = 0;
        this.array = inputArr;
        this.length = array.length;
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
        int pivot = array[lowerIndex + (higherIndex - lowerIndex) / 2];

        nr++;
        //nope
        while (i <= j) {
            nr++;
            while (array[i] > pivot) {
                i++;
            }
            nr++;
            while (array[j] < pivot) {
                j--;
            }
            nr++;
            //nope
            if (i <= j) {
                exchangeNumbers(i, j);
                i++;
                j--;
            }
        }
        nr++;
        if (lowerIndex < j) {
            quickSortGT(lowerIndex, j);
        }
        nr++;
        if (i < higherIndex) {
            quickSortGT(i, higherIndex);
        }
    }

    private void quickSortLT(int lowerIndex, int higherIndex) {

        int i = lowerIndex;
        int j = higherIndex;
        int pivot = array[lowerIndex + (higherIndex - lowerIndex) / 2];
        nr++;

        while (i <= j) {
            nr++;
            while (array[i] < pivot) {
                i++;
            }
            nr++;
            while (array[j] > pivot) {
                j--;
            }
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
        nr++;
        if (lowerIndex < j) {
            quickSortLT(lowerIndex, j);
        }

        nr++;
        if (i < higherIndex) {
            quickSortLT(i, higherIndex);
        }
    }

    private void exchangeNumbers(int i, int j) {
        swap++;
        int temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
}
