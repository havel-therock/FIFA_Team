package lista3;

import java.util.Random;
import java.util.Scanner;

public class Zad2 {
	static int[] array;
	static int[] resultArrayRS;
	static int[] resultArrayS;
	static int length;
	static int number;
	static int swapCounter;
	static int comparCounter;
	
	 static void shuffleArray(int[] ar)
	  {
	    Random rnd = new Random();
	    for (int i = ar.length - 1; i > 0; i--)
	    {
	      int index = rnd.nextInt(i + 1);      
	      swap(ar,index,i);	
	    }
	  }
	 
	 private static void swap(int[] result, int z, int j) {
			int temp;
			temp = result[j];
			result[j] = result[z];
			result[z] = temp;
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
				for(int i=0;i<length;i++){
					array[i]=rnd.nextInt(1000);
				}
				int odp;
				select(array,number);
				odp = randomizedSelect(array,0,length-1,number);
				for(int i=0;i<length;i++){
					if(array[i]!=odp)
						System.out.print(array[i] + ", ");
					else
						System.out.print("[ " + array[i] + " ] , ");
				}
				System.out.println();
			} else if (args[0].equals("-p")){
				for(int i=0;i<length;i++){
					array[i]=i;
				}
				shuffleArray(array);
				int odp;
				select(array,number);
				odp = randomizedSelect(array,0,length-1,number);
				for(int i=0;i<length;i++){
					if(array[i]!=odp)
						System.out.print(array[i] + ", ");
					else
						System.out.print("[ " + array[i] + " ] , ");
				}
				System.out.println();
			} else{
				System.out.println("Wpisz -r albo -p");
				System.exit(0);
			}

		
	}

	private static int [] select(int[] T, int num) {
		
		return null;
	}

	private static int randomizedSelect(int[] T,int p, int k ,int num) {
		for(int i=0;i<length;i++)
			System.err.print(T[i] + ", ");
	    System.err.println();
		int r = randomPartition(T,p,k,num);
		int z=r-p+1;
		if(z==num)
			return T[r];
		if(z<num)
			return randomizedSelect(T, r+1, k, num-z);
		else
			return randomizedSelect(T, p, r-1, num);
	}

	private static int randomPartition(int[] T, int p, int k,int num) {
		Random rnd = new Random();
		int r = p + rnd.nextInt(k-p+1);
		System.err.println("PIVOT -> " + T[r] + " pocz�tek -> " + T[p] + " koniec -> " + T[k] + " k -> " + num);
		int value = T[r];
		swap(T,r,p);
		int i = p;
		for (int j = p + 1; j <= k; j++) {
			// System.err.println("Porównuję " + value + " > " +
			// T[j]);
			comparCounter++;
			if (value > T[j]) {
				i++;
				swap(T, i, j);
				// System.err.println("Zamieniam " + T[i] + " z " +
				// T[j]);
				swapCounter++;
			}
		}
		// System.err.println("Zamieniam " + T[r] + " z " +
		// T[i]);
		swapCounter++;
		swap(T,p,i);
		return i;
	}

}
