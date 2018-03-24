import java.util.Scanner;

/**
 * 
 * @author Janek
 *
 */
public class ListaDruga {

	static int[] array;
	static int[] resultArray;
	static int length;
	static int swapCounter;
	static int comparCounter;
	private static long totalTime;

	public static int[] insertionSort(int[] input, int lenght, boolean fromSmallest) {

		int[] sortedTable = new int[lenght];
		sortedTable[0] = input[0];

		if (fromSmallest) {
			int j = 1;
			int value;
			while (j < lenght) {
				value = input[j];
				for (int i = j - 1; i >= 0; i--) {
					System.err.println("Porównuję " + sortedTable[i] + " <= " + value);
					comparCounter++;
					if (sortedTable[i] <= value) {
						sortedTable[i + 1] = value;
						j++;
						System.err.println("Zamieniam " + sortedTable[i + 1] + " na " + value);
						swapCounter++;
						break;
					} else {
						sortedTable[i + 1] = sortedTable[i];
						System.err.println("Zamieniam " + sortedTable[i + 1] + " na " + sortedTable[i]);
						swapCounter++;
						if (i == 0) {
							System.err.println("Zamieniam " + sortedTable[i] + " na " + value);
							swapCounter++;
							sortedTable[i] = value;
							j++;
						}
					}
				}
			}
		} else {
			int j = 1;
			int value;
			while (j < lenght) {
				value = input[j];
				for (int i = j - 1; i >= 0; i--) {
					System.err.println("Porównuję " + sortedTable[i] + " > " + value);
					comparCounter++;
					if (sortedTable[i] >= value) {
						System.err.println("Zamieniam " + sortedTable[i + 1] + " na " + value);
						swapCounter++;
						sortedTable[i + 1] = value;
						j++;
						break;
					} else {
						sortedTable[i + 1] = sortedTable[i];
						System.err.println("Zamieniam " + sortedTable[i + 1] + " na " + sortedTable[i]);
						swapCounter++;
						if (i == 0) {
							System.err.println("Zamieniam " + sortedTable[i] + " na " + value);
							swapCounter++;
							sortedTable[i] = value;
							j++;
						}
					}
				}
			}
		}

		return sortedTable;
	}

	public static int[] mergeSort(int[] input, boolean fromSmallest, int firstIndex, int lastIndex) {
		int lenght = lastIndex - firstIndex + 1;
		int[] sortedTable = new int[lenght];

		if (lastIndex != firstIndex) {
			int halfIndex = lastIndex - lenght / 2;
			int lenght1 = halfIndex - firstIndex + 1;
			int[] sortedTable1 = new int[lenght1];
			int lenght2 = lastIndex - halfIndex;
			int[] sortedTable2 = new int[lenght2];
			sortedTable1 = mergeSort(input, fromSmallest, firstIndex, halfIndex);
			sortedTable2 = mergeSort(input, fromSmallest, halfIndex + 1, lastIndex);

			if (fromSmallest) {
				int i = 0;
				int j = 0;
				int z = 0;
				while (i < lenght1 && j < lenght2) {
					System.err.println("Porównuję " + sortedTable[i] + " >= " + sortedTable[j]);
					comparCounter++;
					if (sortedTable1[i] >= sortedTable2[j]) {
						sortedTable[z] = sortedTable2[j];
						System.err.println("Zamieniam " + sortedTable[z] + " na " + sortedTable2[j]);
						swapCounter++;
						z++;
						j++;
					} else {
						sortedTable[z] = sortedTable1[i];
						System.err.println("Zamieniam " + sortedTable[z] + " na " + sortedTable1[i]);
						swapCounter++;
						z++;
						i++;
					}
				}
				while (j < lenght2) {
					sortedTable[z] = sortedTable2[j];
					System.err.println("Zamieniam " + sortedTable[z] + " na " + sortedTable2[j]);
					swapCounter++;
					z++;
					j++;
				}
				while (i < lenght1) {
					sortedTable[z] = sortedTable1[i];
					System.err.println("Zamieniam " + sortedTable[z] + " na " + sortedTable1[i]);
					swapCounter++;
					z++;
					i++;
				}
				return sortedTable;
			} else {
				int i = 0;
				int j = 0;
				int z = 0;
				while (i < lenght1 && j < lenght2) {
					System.err.println("Porównuję " + sortedTable[i] + " < " + sortedTable[j]);
					comparCounter++;
					if (sortedTable1[i] < sortedTable2[j]) {
						System.err.println("Zamieniam " + sortedTable[z] + " na " + sortedTable2[j]);
						swapCounter++;
						sortedTable[z] = sortedTable2[j];
						z++;
						j++;
					} else {
						System.err.println("Zamieniam " + sortedTable[z] + " na " + sortedTable1[i]);
						swapCounter++;
						sortedTable[z] = sortedTable1[i];
						z++;
						i++;
					}
				}
				while (j < lenght2) {
					System.err.println("Zamieniam " + sortedTable[z] + " na " + sortedTable2[j]);
					swapCounter++;
					sortedTable[z] = sortedTable2[j];
					z++;
					j++;
				}
				while (i < lenght1) {
					System.err.println("Zamieniam " + sortedTable[z] + " na " + sortedTable1[i]);
					swapCounter++;
					sortedTable[z] = sortedTable1[i];
					z++;
					i++;
				}
				return sortedTable;
			}
		} else {
			System.err.println("Zamieniam " + sortedTable[0] + " na " + input[lastIndex]);
			swapCounter++;
			sortedTable[0] = input[lastIndex];
			return sortedTable;
		}
	}

	public static int[] quickSort(int[] input, boolean fromSmallest, int firstIndex, int lastIndex) {

		int pivot = firstIndex;
		int[] result = input.clone();

		if (fromSmallest) {
			int i = pivot;
			int value = result[pivot];
			for (int j = firstIndex + 1; j <= lastIndex; j++){
				System.err.println("Porównuję " + value + " > " + result[j]);
				comparCounter++;
				if (value > result[j]) {
					i++;
					swap(result, i, j);
					System.err.println("Zamieniam " + result[i] + " z " + result[j]);
					swapCounter++;
				}
			}
			System.err.println("Zamieniam " + result[pivot] + " z " + result[i]);
			swapCounter++;
			result[pivot] = result[i];
			result[i] = value;
			pivot = i;
		} else {
			int i = pivot;
			int value = result[pivot];
			for (int j = firstIndex + 1; j <= lastIndex; j++){
				System.err.println("Porównuję " + value + " < " + result[j]);
				comparCounter++;
				if (value < result[j]) {
					i++;
					swap(result, i, j);
					System.err.println("Zamieniam " + result[i] + " z " + result[j]);
					swapCounter++;
				}
			}
			System.err.println("Zamieniam " + result[pivot] + " z " + result[i]);
			swapCounter++;
			result[pivot] = result[i];
			result[i] = value;
			pivot = i;
		}

		if (firstIndex != pivot)
			result = quickSort(result, fromSmallest, firstIndex, pivot - 1);
		if (lastIndex != pivot)
			result = quickSort(result, fromSmallest, pivot + 1, lastIndex);
		return result;
	}

	public static int[] dualPivotSort(int[] input, boolean fromSmallest, int firstIndex, int lastIndex) {
		int pivotS = firstIndex;
		int pivotL = lastIndex;

		int[] result = input.clone();

		if (fromSmallest) {
			System.err.println("Porównuję " + result[pivotS] + " > " + result[pivotL]);
			comparCounter++;
			if (result[pivotS] > result[pivotL]) {
				swap(result, pivotL, pivotS);
				System.err.println("Zamieniam " + result[pivotL] + " z " + result[pivotS]);
				swapCounter++;
			}
			int i = pivotS;
			int z = pivotL;
			int counterS = 0;
			int counterL = 0;
			int valueS = result[pivotS];
			int valueL = result[pivotL];
			for (int j = firstIndex + 1; j < z; j++) {
				if (counterS > counterL) {
					System.err.println("Porównuję " + valueS + " > " + result[j]);
					comparCounter++;
					if (valueS > result[j]) {
						i++;
						counterS++;
						swap(result, i, j);
						System.err.println("Zamieniam " + result[i] + " z " + result[j]);
						swapCounter++;
					} else {
						System.err.println("Porównuję " + valueL + " < " + result[j]);
						comparCounter++;
						if (valueL < result[j]) {
							z--;
							counterL++;
							swap(result, z, j);
							System.err.println("Zamieniam " + result[z] + " z " + result[j]);
							swapCounter++;
							j--;
						}
					}
				} else {
					System.err.println("Porównuję " + valueL + " < " + result[j]);
					comparCounter++;
					if (valueL < result[j]) {
						z--;
						counterL++;
						swap(result, z, j);
						System.err.println("Zamieniam " + result[z] + " z " + result[j]);
						swapCounter++;
						j--;
					} else {
						System.err.println("Porównuję " + valueS + " > " + result[j]);
						comparCounter++;
						if (valueS > result[j]) {
							i++;
							counterS++;
							swap(result, i, j);
							System.err.println("Zamieniam " + result[i] + " z " + result[j]);
							swapCounter++;
						}
					}
				}
			}
			System.err.println("Zamieniam " + result[pivotS] + " z " + result[i]);
			swapCounter++;
			System.err.println("Zamieniam " + result[pivotL] + " z " + result[z]);
			swapCounter++;
			result[pivotS] = result[i];
			result[i] = valueS;
			pivotS = i;
			result[pivotL] = result[z];
			result[z] = valueL;
			pivotL = z;
		} else {
			System.err.println("Porównuję " + result[pivotS] + " < " + result[pivotL]);
			comparCounter++;
			if (result[pivotS] < result[pivotL]) {
				swap(result, pivotL, pivotS);
				System.err.println("Zamieniam " + result[pivotL] + " z " + result[pivotS]);
				swapCounter++;
			}
			int i = pivotS;
			int z = pivotL;
			int counterS = 0;
			int counterL = 0;
			int valueS = result[pivotS];
			int valueL = result[pivotL];
			for (int j = firstIndex + 1; j < z; j++) {
				if (counterS > counterL) {
					System.err.println("Porównuję " + valueS + " < " + result[j]);
					comparCounter++;
					if (valueS < result[j]) {
						i++;
						counterS++;
						swap(result, i, j);
						System.err.println("Zamieniam " + result[i] + " z " + result[j]);
						swapCounter++;
					} else {
						System.err.println("Porównuję " + valueL + " > " + result[j]);
						comparCounter++;
						if (valueL > result[j]) {
							z--;
							counterL++;
							swap(result, z, j);
							System.err.println("Zamieniam " + result[z] + " z " + result[j]);
							swapCounter++;
							j--;
						}
					}
				} else {
					System.err.println("Porównuję " + valueL + " > " + result[j]);
					comparCounter++;
					if (valueL > result[j]) {
						z--;
						counterL++;
						swap(result, z, j);
						System.err.println("Zamieniam " + result[z] + " z " + result[j]);
						swapCounter++;
						j--;
					} else {
						System.err.println("Porównuję " + valueS + " < " + result[j]);
						comparCounter++;
						if (valueS < result[j]) {
							i++;
							counterS++;
							swap(result, i, j);
							System.err.println("Zamieniam " + result[i] + " z " + result[j]);
							swapCounter++;
						}
					}
				}
			}
			System.err.println("Zamieniam " + result[pivotS] + " z " + result[i]);
			swapCounter++;
			System.err.println("Zamieniam " + result[pivotL] + " z " + result[z]);
			swapCounter++;
			result[pivotS] = result[i];
			result[i] = valueS;
			pivotS = i;
			result[pivotL] = result[z];
			result[z] = valueL;
			pivotL = z;
		}
		if (firstIndex != pivotS)
			result = dualPivotSort(result, fromSmallest, firstIndex, pivotS - 1);
		if (lastIndex != pivotL)
			result = dualPivotSort(result, fromSmallest, pivotL + 1, lastIndex);
		if (pivotL - pivotS > 2)
			result = dualPivotSort(result, fromSmallest, pivotS + 1, pivotL - 1);
		return result;
	}

	private static void swap(int[] result, int z, int j) {
		int temp;
		temp = result[j];
		result[j] = result[z];
		result[z] = temp;
	}

	public static void main(String[] args) {

		Scanner reader = new Scanner(System.in);
		System.out.println("Podaj długośc tablicy");
		length = reader.nextInt();
		if (length < 1) {
			System.out.println("Zly rozmiar");
			System.exit(0);

		}
		array = new int[length];
		swapCounter = 0;
		comparCounter = 0;
		System.out.println("lenght: " + length);
		System.out.println("Podaj tablicę");
		for (int i = 0; i < length; i++) {
			array[i] = reader.nextInt();
		}

		if (args[0].equals("--type") && args[2].equals("--comp")) {
			if (args[1].equals("insert")) {
				if (args[3].equals(">=")) {
					long startTime = System.nanoTime();
					resultArray = insertionSort(array, length, false);
					long endTime = System.nanoTime();
					totalTime = endTime - startTime;
					System.err.println("Czas dzialania insertsort " + totalTime);
				} else if (args[3].equals("<=")) {
					long startTime = System.nanoTime();
					resultArray = insertionSort(array, length, true);
					long endTime = System.nanoTime();
					totalTime = endTime - startTime;
					System.err.println("Czas dzialania insertsort " + totalTime);
				} else {
					System.out.println("Zly comp podaj >= | <=");
					System.exit(0);
				}

			} else if (args[1].equals("merge")) {

				if (args[3].equals(">=")) {
					long startTime = System.nanoTime();
					resultArray = mergeSort(array, false, 0, length - 1);
					long endTime = System.nanoTime();
					totalTime = endTime - startTime;
					System.err.println("Czas dzialania mergesort " + totalTime);
				} else if (args[3].equals("<=")) {
					long startTime = System.nanoTime();
					resultArray = mergeSort(array, true, 0, length - 1);
					long endTime = System.nanoTime();
					totalTime = endTime - startTime;
					System.err.println("Czas dzialania mergesort " + totalTime);
				} else {
					System.out.println("Zly comp podaj >= | <=");
					System.exit(0);
				}

			} else if (args[1].equals("quick")) {

				if (args[3].equals(">=")) {
					long startTime = System.nanoTime();
					resultArray = quickSort(array, false, 0, length - 1);
					long endTime = System.nanoTime();
					totalTime = endTime - startTime;
					System.err.println("Czas dzialania quicksort " + totalTime);
				} else if (args[3].equals("<=")) {
					long startTime = System.nanoTime();
					resultArray = quickSort(array, true, 0, length - 1);
					long endTime = System.nanoTime();
					totalTime = endTime - startTime;
					System.err.println("Czas dzialania quicksort " + totalTime);
				} else {
					System.out.println("Zly comp podaj >= | <=");
					System.exit(0);
				}

			} else if (args[1].equals("dual")) {

				if (args[3].equals(">=")) {
					long startTime = System.nanoTime();
					resultArray = dualPivotSort(array, false, 0, length - 1);
					long endTime = System.nanoTime();
					totalTime = endTime - startTime;
					System.err.println("Czas dzialania dualsort " + totalTime);
				} else if (args[3].equals("<=")) {
					long startTime = System.nanoTime();
					resultArray = dualPivotSort(array, true, 0, length - 1);
					long endTime = System.nanoTime();
					totalTime = endTime - startTime;
					System.err.println("Czas dzialania dualsort " + totalTime);
				} else {
					System.out.println("Zly comp podaj >= | <=");
					System.exit(0);
				}
			} else {
				System.out.println("Wybierz insert|merge|quick|dual");
				System.exit(0);
			}
		} else {
			System.out.println("Zly comp --type i --comp");
			System.exit(0);
		}
		System.out.println("tablica");
		for (int i = 0; i < length; i++)
			System.out.print(array[i] + " , ");
		System.out.println();
		System.out.println("Posortowana tablica");
		for (int i = 0; i < length; i++)
			System.out.print(resultArray[i] + " , ");
		if (args[3].equals(">="))
			for (int i = 0; i < length - 1; i++)
				if (resultArray[i] < resultArray[i + 1]) {
					System.out.println("BŁĄD SORTOWANIA!!!!!!!!!!!!!!");
					System.exit(0);
				} else
					;
		else
			for (int i = 0; i < length - 1; i++)
				if (resultArray[i] > resultArray[i + 1]) {
					System.out.println("BŁĄD SORTOWANIA!!!!!!!!!!!!!!");
					System.exit(0);
				}
		;

		System.out.println();
		System.out.println("Liczba posortowanych elementów : " + length);
		System.err.println("Liczba porównañ : " + comparCounter + " Liczba przestawieñ : " + swapCounter);
	}

}
