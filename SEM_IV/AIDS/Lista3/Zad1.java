package lista3;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Random;
import java.util.Scanner;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

/**
 * 
 * @author Janek
 *
 */
public class Zad1 {

	static int[] array;
	static int[] resultArray;
	static int length;
	static int swapCounter;
	static int comparCounter;
	private static long totalTime;

	public static int[] radixSort(int[] input,Boolean bool,int lenght) {
		int[] sortedTable = new int[lenght];
		sortedTable = input;
		int maximum=input[0];
		int x=10;
		Boolean ready=true;
		for(int i=1;i<lenght;i++){
			 System.err.println("Porownoje " + maximum + " < " + input[i]);
			 comparCounter++;
			if(maximum<input[i])
				maximum=input[i];
		}
		while(ready){
			 System.err.println("Porownoje " + maximum/x + " == " + 0);
			 comparCounter++;
			if(maximum/x==0)
				ready=false;
			else
				x*=10;
		}
		if(bool){
			for (int place = 1; place < x; place *= 10)
				sortedTable = countSort(sortedTable, lenght, place);
			return sortedTable;
		}
		else{
			for (int place = 1; place < x; place *= 10)
				sortedTable = countSortOpp(sortedTable, lenght, place);
			return sortedTable;
		}
	}

	public static int[] countSort(int[] input, int lenght, int place) {
		int[] sortedTable = new int[lenght];
		int[] C = new int[10];
		int[] lastNumbers = getLastNumbers(input, place, lenght);
		for (int i = 0; i < 10; i++)
			C[i] = 0;
		for (int i = 0; i < lenght; i++)
			C[lastNumbers[i]]++;
		for (int i = 1; i < 10; i++)
			C[i] = C[i] + C[i - 1];
		for (int i = lenght - 1; i >= 0; i--) {
			sortedTable[C[lastNumbers[i]]-1] = input[i];
			C[lastNumbers[i]]--;
		}
		return sortedTable;
	}
	
	public static int[] countSortOpp(int[] input, int lenght, int place) {
		int[] sortedTable = new int[lenght];
		int[] C = new int[10];
		int[] lastNumbers = getLastNumbers(input, place, lenght);
		for (int i = 0; i < 10; i++)
			C[i] = 0;
		for (int i = 0; i < lenght; i++)
			C[lastNumbers[i]]++;
		for (int i = 1; i < 10; i++)
			C[i] = C[i] + C[i - 1];
		for (int i = 0; i < lenght; i++) {
			sortedTable[lenght-C[lastNumbers[i]]] = input[i];
			C[lastNumbers[i]]--;
		}
		return sortedTable;
	}

	private static int[] getLastNumbers(int[] input, int place, int lenght) {
		int[] lastNumbers = new int[lenght];
		for (int i = 0; i < lenght; i++)
			lastNumbers[i] = (input[i] / place) % 10;
		return lastNumbers;
	}

	public static int[] insertionSort(int[] input, int lenght, boolean fromSmallest) {

		int[] sortedTable = new int[lenght];
		sortedTable[0] = input[0];

		if (fromSmallest) {
			int j = 1;
			int value;
			while (j < lenght) {
				value = input[j];
				for (int i = j - 1; i >= 0; i--) {
					// System.err.println("Porównuję " + sortedTable[i] + " <=
					// " + value);
					comparCounter++;
					if (sortedTable[i] <= value) {
						sortedTable[i + 1] = value;
						j++;
						// System.err.println("Zamieniam " + sortedTable[i + 1]
						// + " na " + value);
						swapCounter++;
						break;
					} else {
						sortedTable[i + 1] = sortedTable[i];
						// System.err.println("Zamieniam " + sortedTable[i + 1]
						// + " na " + sortedTable[i]);
						swapCounter++;
						if (i == 0) {
							// System.err.println("Zamieniam " + sortedTable[i]
							// + " na " + value);
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
					// System.err.println("Porównuję " + sortedTable[i] + " >
					// " + value);
					comparCounter++;
					if (sortedTable[i] >= value) {
						// System.err.println("Zamieniam " + sortedTable[i + 1]
						// + " na " + value);
						swapCounter++;
						sortedTable[i + 1] = value;
						j++;
						break;
					} else {
						sortedTable[i + 1] = sortedTable[i];
						// System.err.println("Zamieniam " + sortedTable[i + 1]
						// + " na " + sortedTable[i]);
						swapCounter++;
						if (i == 0) {
							// System.err.println("Zamieniam " + sortedTable[i]
							// + " na " + value);
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
					// System.err.println("Porównuję " + sortedTable[i] + " >=
					// " + sortedTable[j]);
					comparCounter++;
					if (sortedTable1[i] >= sortedTable2[j]) {
						sortedTable[z] = sortedTable2[j];
						// System.err.println("Zamieniam " + sortedTable[z] + "
						// na " + sortedTable2[j]);
						swapCounter++;
						z++;
						j++;
					} else {
						sortedTable[z] = sortedTable1[i];
						// System.err.println("Zamieniam " + sortedTable[z] + "
						// na " + sortedTable1[i]);
						swapCounter++;
						z++;
						i++;
					}
				}
				while (j < lenght2) {
					sortedTable[z] = sortedTable2[j];
					// System.err.println("Zamieniam " + sortedTable[z] + " na "
					// + sortedTable2[j]);
					swapCounter++;
					z++;
					j++;
				}
				while (i < lenght1) {
					sortedTable[z] = sortedTable1[i];
					// System.err.println("Zamieniam " + sortedTable[z] + " na "
					// + sortedTable1[i]);
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
					// System.err.println("Porównuję " + sortedTable[i] + " <
					// " + sortedTable[j]);
					comparCounter++;
					if (sortedTable1[i] < sortedTable2[j]) {
						// System.err.println("Zamieniam " + sortedTable[z] + "
						// na " + sortedTable2[j]);
						swapCounter++;
						sortedTable[z] = sortedTable2[j];
						z++;
						j++;
					} else {
						// System.err.println("Zamieniam " + sortedTable[z] + "
						// na " + sortedTable1[i]);
						swapCounter++;
						sortedTable[z] = sortedTable1[i];
						z++;
						i++;
					}
				}
				while (j < lenght2) {
					// System.err.println("Zamieniam " + sortedTable[z] + " na "
					// + sortedTable2[j]);
					swapCounter++;
					sortedTable[z] = sortedTable2[j];
					z++;
					j++;
				}
				while (i < lenght1) {
					// System.err.println("Zamieniam " + sortedTable[z] + " na "
					// + sortedTable1[i]);
					swapCounter++;
					sortedTable[z] = sortedTable1[i];
					z++;
					i++;
				}
				return sortedTable;
			}
		} else {
			// System.err.println("Zamieniam " + sortedTable[0] + " na " +
			// input[lastIndex]);
			swapCounter++;
			sortedTable[0] = input[lastIndex];
			return sortedTable;
		}
	}

	public static int[] quickSort(int[] input, boolean fromSmallest, int firstIndex, int lastIndex) {

		int pivot = firstIndex;
		int[] result = input;

		if (fromSmallest) {
			int i = pivot;
			int value = result[pivot];
			for (int j = firstIndex + 1; j <= lastIndex; j++) {
				// System.err.println("Porównuję " + value + " > " +
				// result[j]);
				comparCounter++;
				if (value > result[j]) {
					i++;
					swap(result, i, j);
					// System.err.println("Zamieniam " + result[i] + " z " +
					// result[j]);
					swapCounter++;
				}
			}
			// System.err.println("Zamieniam " + result[pivot] + " z " +
			// result[i]);
			swapCounter++;
			result[pivot] = result[i];
			result[i] = value;
			pivot = i;
		} else {
			int i = pivot;
			int value = result[pivot];
			for (int j = firstIndex + 1; j <= lastIndex; j++) {
				// System.err.println("Porównuję " + value + " < " +
				// result[j]);
				comparCounter++;
				if (value < result[j]) {
					i++;
					swap(result, i, j);
					// System.err.println("Zamieniam " + result[i] + " z " +
					// result[j]);
					swapCounter++;
				}
			}
			// System.err.println("Zamieniam " + result[pivot] + " z " +
			// result[i]);
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

		int[] result = input;

		if (fromSmallest) {
			// System.err.println("Porównuję " + result[pivotS] + " > " +
			// result[pivotL]);
			comparCounter++;
			if (result[pivotS] > result[pivotL]) {
				swap(result, pivotL, pivotS);
				// System.err.println("Zamieniam " + result[pivotL] + " z " +
				// result[pivotS]);
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
					// System.err.println("Porównuję " + valueS + " > " +
					// result[j]);
					comparCounter++;
					if (valueS > result[j]) {
						i++;
						counterS++;
						swap(result, i, j);
						// System.err.println("Zamieniam " + result[i] + " z " +
						// result[j]);
						swapCounter++;
					} else {
						// System.err.println("Porównuję " + valueL + " < " +
						// result[j]);
						comparCounter++;
						if (valueL < result[j]) {
							z--;
							counterL++;
							swap(result, z, j);
							// System.err.println("Zamieniam " + result[z] + " z
							// " + result[j]);
							swapCounter++;
							j--;
						}
					}
				} else {
					// System.err.println("Porównuję " + valueL + " < " +
					// result[j]);
					comparCounter++;
					if (valueL < result[j]) {
						z--;
						counterL++;
						swap(result, z, j);
						// System.err.println("Zamieniam " + result[z] + " z " +
						// result[j]);
						swapCounter++;
						j--;
					} else {
						// System.err.println("Porównuję " + valueS + " > " +
						// result[j]);
						comparCounter++;
						if (valueS > result[j]) {
							i++;
							counterS++;
							swap(result, i, j);
							// System.err.println("Zamieniam " + result[i] + " z
							// " + result[j]);
							swapCounter++;
						}
					}
				}
			}
			// System.err.println("Zamieniam " + result[pivotS] + " z " +
			// result[i]);
			swapCounter++;
			// System.err.println("Zamieniam " + result[pivotL] + " z " +
			// result[z]);
			swapCounter++;
			result[pivotS] = result[i];
			result[i] = valueS;
			pivotS = i;
			result[pivotL] = result[z];
			result[z] = valueL;
			pivotL = z;
		} else {
			// System.err.println("Porównuję " + result[pivotS] + " < " +
			// result[pivotL]);
			comparCounter++;
			if (result[pivotS] < result[pivotL]) {
				swap(result, pivotL, pivotS);
				// System.err.println("Zamieniam " + result[pivotL] + " z " +
				// result[pivotS]);
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
					// System.err.println("Porównuję " + valueS + " < " +
					// result[j]);
					comparCounter++;
					if (valueS < result[j]) {
						i++;
						counterS++;
						swap(result, i, j);
						// System.err.println("Zamieniam " + result[i] + " z " +
						// result[j]);
						swapCounter++;
					} else {
						// System.err.println("Porównuję " + valueL + " > " +
						// result[j]);
						comparCounter++;
						if (valueL > result[j]) {
							z--;
							counterL++;
							swap(result, z, j);
							// System.err.println("Zamieniam " + result[z] + " z
							// " + result[j]);
							swapCounter++;
							j--;
						}
					}
				} else {
					// System.err.println("Porównuję " + valueL + " > " +
					// result[j]);
					comparCounter++;
					if (valueL > result[j]) {
						z--;
						counterL++;
						swap(result, z, j);
						// System.err.println("Zamieniam " + result[z] + " z " +
						// result[j]);
						swapCounter++;
						j--;
					} else {
						// System.err.println("Porównuję " + valueS + " < " +
						// result[j]);
						comparCounter++;
						if (valueS < result[j]) {
							i++;
							counterS++;
							swap(result, i, j);
							// System.err.println("Zamieniam " + result[i] + " z
							// " + result[j]);
							swapCounter++;
						}
					}
				}
			}
			// System.err.println("Zamieniam " + result[pivotS] + " z " +
			// result[i]);
			swapCounter++;
			// System.err.println("Zamieniam " + result[pivotL] + " z " +
			// result[z]);
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

		if (args.length == 7 && args[4].equals("--stat")) {
			XYSeries nrIS = new XYSeries("Insertion Sort");
			XYSeries nrQS = new XYSeries("Quick Sort");
			XYSeries nrMS = new XYSeries("Marge Sort");
			XYSeries nrDS = new XYSeries("Dual Pivot Sort");
			XYSeriesCollection dataset = new XYSeriesCollection();
			dataset.addSeries(nrIS);
			// dataset.addSeries(nrQS);
			// dataset.addSeries(nrMS);
			dataset.addSeries(nrDS);
			// --type quick --comp <= --stat quick10Comp.txt 10
			String thing = "Comp";
			String name = "ExperimentalFidingCV2_noins_" + args[6] + thing;
			// args[1]="quick";
			// args[5]=args[1] + args[6] + thing;
			// prepereData(args, nrIS, nrQS, nrMS, nrDS);
			args[1] = "dual";
			args[5] = args[1] + args[6] + thing;
			prepereData(args, nrIS, nrQS, nrMS, nrDS);
			for (int i = 0; i < 10000; i++)
				nrIS.add(i, 2 * i * Math.log(i));
			// args[1]="insert";
			// args[5]=args[1] + args[6] + thing;
			// prepereData(args, nrIS, nrQS, nrMS, nrDS);
			// args[1]="merge";
			// args[5]=args[1] + args[6] + thing;
			// prepereData(args, nrIS, nrQS, nrMS, nrDS);
			JFreeChart compars = ChartFactory.createXYLineChart(name, // Title
					"elements", // x-axis Label
					thing, // y-axis Label
					dataset, // Dataset
					PlotOrientation.VERTICAL, // Plot Orientation
					true, // Show Legend
					true, // Use tooltips
					false // Configure chart to generate URLs?
			);

			try {
				ChartUtilities.saveChartAsJPEG(new File(name + ".jpg"), compars, 1200, 800);
			} catch (IOException e) {
				System.err.println("Problem occurred creating chart.");
			}
		} else {
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

			sort(args);
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
						System.out.println("B��D SORTOWANIA!!!!!!!!!!!!!!");
						System.exit(0);
					} else
						;
			else
				checkSort(args);

			System.out.println();
			System.out.println("Liczba posortowanych element�w : " + length);
			System.err.println("Liczba por�wna� : " + comparCounter + " Liczba przestawiee� : " + swapCounter);
		}
	}

	private static void prepereData(String[] args, XYSeries nrIS, XYSeries nrQS, XYSeries nrMS, XYSeries nrDS) {
		int k = Integer.parseInt(args[6]);
		int j = 0;
		int timesummer, swapsummer, comparsummer;
		PrintStream out;
		try {
			String nazwaPliku = args[5];
			out = new PrintStream(new FileOutputStream(nazwaPliku));
			System.setOut(out);
			Random ran = new Random();
			for (int n = 100; n <= 10000; n = n + 100) {
				length = n;
				swapCounter = 0;
				comparCounter = 0;
				timesummer = 0;
				comparsummer = 0;
				swapsummer = 0;
				j = 0;
				while (j < k) {
					array = new int[n];
					for (int i = 0; i < length; i++) {
						if (ran.nextInt(2) == 0)
							array[i] = -ran.nextInt(1000);
						else
							array[i] = ran.nextInt(1000);
					}
					sort(args);
					checkSort(args);
					timesummer += totalTime;
					comparsummer += comparCounter;
					swapsummer += swapCounter;
					System.out.println(length + "," + comparCounter + "," + swapCounter + "," + totalTime);
					j++;
				}
				timesummer /= k;
				comparsummer /= k;
				swapsummer /= k;
				int ilorazC = comparsummer / n;
				int ilorazS = swapsummer / n;
				switch (args[1]) {
				case "insert":
					nrIS.add(length, swapsummer);
					break;
				case "merge":
					nrMS.add(length, swapsummer);
					break;
				case "quick":
					nrQS.add(length, swapsummer);
					break;
				case "dual":
					nrDS.add(length, comparsummer);
					break;
				}
			}
			out.close();
		} catch (FileNotFoundException e) {
			System.out.println("Nie ma pliku");
			e.printStackTrace();
		}
	}

	private static void checkSort(String[] args) {
		if (args[3].equals("<="))
			for (int i = 0; i < length - 1; i++)
				if (resultArray[i] > resultArray[i + 1]) {
					System.out.println("B��D SORTOWANIA!!!!!!!!!!!!!!");
					System.exit(0);
				} else
					;
		else
			for (int i = 0; i < length - 1; i++)
				if (resultArray[i] < resultArray[i + 1]) {
					System.out.println("B��D SORTOWANIA!!!!!!!!!!!!!!");
					System.exit(0);
				}
	}

	private static void sort(String[] args) {
		try {
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
						int[] arrayClone;
						arrayClone = array.clone();
						long startTime = System.nanoTime();
						resultArray = quickSort(arrayClone, false, 0, length - 1);
						long endTime = System.nanoTime();
						totalTime = endTime - startTime;
						System.err.println("Czas dzialania quicksort " + totalTime);
					} else if (args[3].equals("<=")) {
						int[] arrayClone;
						arrayClone = array.clone();
						long startTime = System.nanoTime();
						resultArray = quickSort(arrayClone, true, 0, length - 1);
						long endTime = System.nanoTime();
						totalTime = endTime - startTime;
						System.err.println("Czas dzialania quicksort " + totalTime);
					} else {
						System.out.println("Zly comp podaj >= | <=");
						System.exit(0);
					}

				} else if (args[1].equals("dual")) {

					if (args[3].equals(">=")) {
						int[] arrayClone;
						arrayClone = array.clone();
						long startTime = System.nanoTime();
						resultArray = dualPivotSort(arrayClone, false, 0, length - 1);
						long endTime = System.nanoTime();
						totalTime = endTime - startTime;
						System.err.println("Czas dzialania dualsort " + totalTime);
					} else if (args[3].equals("<=")) {
						int[] arrayClone;
						arrayClone = array.clone();
						long startTime = System.nanoTime();
						resultArray = dualPivotSort(arrayClone, true, 0, length - 1);
						long endTime = System.nanoTime();
						totalTime = endTime - startTime;
						System.err.println("Czas dzialania dualsort " + totalTime);
					} else {
						System.out.println("Zly comp podaj >= | <=");
						System.exit(0);
					}
				} else if (args[1].equals("radix")) {

					if (args[3].equals(">=")) {
						int[] arrayClone;
						arrayClone = array.clone();
						long startTime = System.nanoTime();
						resultArray = radixSort(arrayClone,false,length);
						long endTime = System.nanoTime();
						totalTime = endTime - startTime;
						System.err.println("Czas dzialania radixsort " + totalTime);
					} else if (args[3].equals("<=")) {
						int[] arrayClone;
						arrayClone = array.clone();
						long startTime = System.nanoTime();
						resultArray = radixSort(arrayClone,true,length);
						long endTime = System.nanoTime();
						totalTime = endTime - startTime;
						System.err.println("Czas dzialania radixsort " + totalTime);
					} else {
						System.out.println("Zly comp podaj >= | <=");
						System.exit(0);
					}
				} else {
					System.out.println("Wybierz insert|merge|quick|dual|radix");
					System.exit(0);
				}
			} else {
				System.out.println("Zly comp --type i --comp");
				System.exit(0);
			}

		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println("Nast�pnym razem wpisz parametry");
			System.exit(0);
		}

	}

}
