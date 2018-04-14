

import java.util.Random;
import java.util.Scanner;

public class Zad2 {
	static int[] array;
	static int[] array2;
	static int[] resultArrayRS;
	static int[] resultArrayS;
	static int length;
	static int number;
	static int swapCounter;
	static int comparCounter;

	static void shuffleArray(int[] ar) {
		Random rnd = new Random();
		for (int i = ar.length - 1; i > 0; i--) {
			int index = rnd.nextInt(i + 1);
			swap(ar, index, i);
		}
	}

	private static void swap(int[] result, int z, int j) {
		int temp;
		temp = result[j];
		result[j] = result[z];
		result[z] = temp;
	}

	public static int[] insertionSort(int[] input, int p, int k, boolean fromSmallest) {

		int[] sortedTable = new int[k - p + 1];
		sortedTable[0] = input[p];

		if (fromSmallest) {
			int j = 1;
			int value;
			while (j < k - p + 1) {
				System.err.println("Porownoje " + j + " <= " +
						 (k-p+1));
						comparCounter++;
				value = input[p + j];
				for (int i = j - 1; i >= 0; i--) {
					 System.err.println("Porownoje " + sortedTable[i] + " <= " +
							 value);
							comparCounter++;
					if (sortedTable[i] <= value) {
						sortedTable[i + 1] = value;
						j++;

						break;
					} else {
						sortedTable[i + 1] = sortedTable[i];

						if (i == 0) {
							sortedTable[i] = value;
							j++;
						}
					}
				}
			}
		}

		return sortedTable;
	}

	public static void main(String[] args) {

		Scanner reader = new Scanner(System.in);
		System.out.println("Podaj dlugoscc tablicy");
		length = reader.nextInt();
		if (length < 1) {
			System.out.println("Zly rozmiar");
			System.exit(0);
		}
		array = new int[length];
		array2 = new int[length];
		swapCounter = 0;
		comparCounter = 0;

		System.out.println("Podaj numer k szukanej statystyki pozycyjnej (1 <= k <= n)");
		number = reader.nextInt();
		if (number < 1 || number > length) {
			System.out.println("Zla liczba");
			System.exit(0);
		}

		if (args[0].equals("-r")) {
			Random rnd = new Random();
			int temp;
			for (int i = 0; i < length; i++) {
				temp = rnd.nextInt(1000);
				array[i] = temp;
				array2[i] = temp;
			}
			int odp;
			odp = select(array, 0, length - 1, number);
			for (int i = 0; i < length; i++) {
				if (array[i] != odp)
					System.out.print(array[i] + ", ");
				else
					System.out.print("[ " + array[i] + " ] , ");
			}
			System.out.println();
			System.err.println();
			System.err.println("ILOSC POROWNAN " + comparCounter + " ILOSC PRZESTAWIEN " + swapCounter);
			System.out.println("TERAZ RANDOMIZEZ SELECT (WCZESNIEJ SELECT)");
			swapCounter = 0;
			comparCounter = 0;
			odp = randomizedSelect(array2,0,length-1,number);
			for (int i = 0; i < length; i++) {
				if (array2[i] != odp)
					System.out.print(array2[i] + ", ");
				else
					System.out.print("[ " + array2[i] + " ] , ");
			}
			System.err.println();
			System.err.println("ILOSC POROWNAN " + comparCounter + " ILOSC PRZESTAWIEN " + swapCounter);
			System.out.println();
		} else if (args[0].equals("-p")) {
			for (int i = 0; i < length; i++) {
				array[i] = i;
				array2[i]= i;
			}
			shuffleArray(array);
			int odp;
			odp = select(array, 0, length - 1, number);
			Boolean bool = false;
			for (int i = 0; i < length; i++) {
				if (array[i] != odp || bool)
					System.out.print(array[i] + ", ");
				else{
					System.out.print("[ " + array[i] + " ] , ");
					bool=true;
				}
			}
			System.out.println();
			System.err.println();
			System.err.println("ILOSC POROWNAN " + comparCounter + " ILOSC PRZESTAWIEN " + swapCounter);
			System.out.println("TERAZ RANDOMIZEZ SELECT (WCZESNIEJ SELECT)");
			swapCounter = 0;
			comparCounter = 0;
			odp = randomizedSelect(array2,0,length-1,number);
			bool = false;
			for (int i = 0; i < length; i++) {
				if (array2[i] != odp || bool)
					System.out.print(array2[i] + ", ");
				else{
					System.out.print("[ " + array2[i] + " ] , ");
					bool=true;
				}
			}
			System.err.println();
			System.err.println("ILOSC POROWNAN " + comparCounter + " ILOSC PRZESTAWIEN " + swapCounter);
			System.out.println();
		} else {
			System.out.println("Wpisz -r albo -p");
			System.exit(0);
		}

	}

	private static int select(int[] T, int p, int k, int num) {
		int x = 0;
		int xv;
		int helper = p;
		int lenght2 = k - p + 1;
		int[] sortedTable;
		int[] median;
		
		if ((lenght2) % 5 == 0)
			median = new int[((lenght2) / 5)];
		else
			median = new int[((lenght2) / 5) + 1];

		while ((helper + 5) <= k + 1) {
			 System.err.println("Porownoje " + helper+5 + " <= " +
					 k+1);
					comparCounter++;
			helper = helper + 5;
			sortedTable = insertionSort(T, helper - 5, helper - 1, true);
			median[((helper - p) / 5) - 1] = sortedTable[2];
		}

		if ((lenght2) % 5 != 0) {
			sortedTable = insertionSort(T, helper, k, true);
			median[(lenght2) / 5] = sortedTable[sortedTable.length / 2];
		}
		
		if (median.length == 1) {
			if (p != k) {
				sortedTable = insertionSort(T, p, k, true);
				return sortedTable[num - 1];
			}
			return T[k];
		}

		xv = select(median, 0, median.length - 1, (median.length / 2) + 1);

		for (int i = p; i <= k; i++)
			if (T[i] == xv) {
				x = i;
				break;
			}
		for (int i = 0; i < T.length; i++)
			System.err.print(T[i] + ", ");
		System.err.println();
		x = partition(T, p, k, num, x);
		int z = x - p + 1;
		if (z == num)
			return T[x];
		 System.err.println("Porownoje " + z + " < " +
				 num);
				comparCounter++;
		if (z < num)
			return select(T, x + 1, k, num - z);
		else
			return select(T, p, x - 1, num);
	}

	private static int randomizedSelect(int[] T, int p, int k, int num) {
		for (int i = 0; i < length; i++)
			System.err.print(T[i] + ", ");
		System.err.println();
		int r = randomPartition(T, p, k, num);
		int z = r - p + 1;
		if (z == num)
			return T[r];
		 System.err.println("Porownoje " + z + " < " +
				 num);
				comparCounter++;
		if (z < num)
			return randomizedSelect(T, r + 1, k, num - z);
		else
			return randomizedSelect(T, p, r - 1, num);
	}

	private static int randomPartition(int[] T, int p, int k, int num) {
		Random rnd = new Random();
		int r = p + rnd.nextInt(k - p + 1);
		System.err.println("[W WARTOSCIACH] PIVOT -> " + T[r] + " poczatek -> " + T[p] + " koniec -> " + T[k] + " k -> " + num);
		int value = T[r];
		swap(T, r, p);
		int i = p;
		for (int j = p + 1; j <= k; j++) {
			 System.err.println("Porownoje " + value + " > " +
			 T[j]);
			comparCounter++;
			if (value > T[j]) {
				i++;
				swap(T, i, j);
				 System.err.println("Zamieniam " + T[i] + " z " +
				 T[j]);
				swapCounter++;
			}
		}
		 System.err.println("Zamieniam " + T[p] + " z " +
		 T[i]);
		swapCounter++;
		swap(T, p, i);
		return i;
	}

	private static int partition(int[] T, int p, int k, int num, int x) {
		int r = x;
		System.err.println("[W WARTOSCIACH] PIVOT -> " + T[r] + " poczatek -> " + T[p] + " koniec -> " + T[k] + " k -> " + num);
		int value = T[r];
		swap(T, r, p);
		int i = p;
		for (int j = p + 1; j <= k; j++) {
			 System.err.println("Porownoje " + value + " > " +
			 T[j]);
			comparCounter++;
			if (value > T[j]) {
				i++;
				swap(T, i, j);
				 System.err.println("Zamieniam " + T[i] + " z " +
				 T[j]);
				swapCounter++;
			}
		}
		 System.err.println("Zamieniam " + T[p] + " z " +
		 T[i]);
		swapCounter++;
		swap(T, p, i);
		return i;
	}
}
