
/**
 *
 * @author jakub
 */
public class MergeSort {

    private int[] array;
    private int[] tempMergArr;
    private int length;
    private boolean gl;
    long totalTime;
    int nr;
    int swap;

    public void sort(int inputArr[], boolean gl) {
        this.array = inputArr;
        this.length = inputArr.length;
        this.tempMergArr = new int[length];
        this.gl = gl;
        nr = 0;
        swap=0;
        doMergeSort(0, length - 1);
    }

    private void doMergeSort(int lowerIndex, int higherIndex) {
        long startTime = System.nanoTime();
        nr++;
        if (lowerIndex < higherIndex) {
            int middle = lowerIndex + (higherIndex - lowerIndex) / 2;
            doMergeSort(lowerIndex, middle);
            doMergeSort(middle + 1, higherIndex);
            if (gl) {
                mergePartsGT(lowerIndex, middle, higherIndex);
            } else {
                mergePartsLT(lowerIndex, middle, higherIndex);
            }
        }
        long endTime = System.nanoTime();
        totalTime = endTime - startTime;
    }

    private void mergePartsLT(int lowerIndex, int middle, int higherIndex) {

        for (int i = lowerIndex; i <= higherIndex; i++) {
            tempMergArr[i] = array[i];
        }
        int i = lowerIndex;
        int j = middle + 1;
        int k = lowerIndex;
        nr++;
        while (i <= middle && j <= higherIndex) {
            nr++;
            if (tempMergArr[i] <= tempMergArr[j]) {
                array[k] = tempMergArr[i];
                i++;
            } else {
                array[k] = tempMergArr[j];
                j++;
                swap++;
            }
            k++;
        }
        nr++;
        while (i <= middle) {
            array[k] = tempMergArr[i];
            k++;
            i++;
        }

    }

    private void mergePartsGT(int lowerIndex, int middle, int higherIndex) {

        for (int i = lowerIndex; i <= higherIndex; i++) {
            tempMergArr[i] = array[i];
        }
        int i = lowerIndex;
        int j = middle + 1;
        int k = lowerIndex;
        nr++;
        while (i <= middle && j <= higherIndex) {
            nr++;
            if (tempMergArr[i] >= tempMergArr[j]) {
                array[k] = tempMergArr[i];
                i++;
            } else {
                array[k] = tempMergArr[j];
                j++;
            }
            k++;
        }
        nr++;
        while (i <= middle) {
            array[k] = tempMergArr[i];
            k++;
            i++;
        }

    }
}
