
import java.util.Random;
import java.util.Scanner;

public class Zad3 {
	static int[] array;
	static int length;
	static int value;
	static int comparCounter;
	private static long totalTime;
	
	private static void swap(int[] result, int z, int j) {
		int temp;
		temp = result[j];
		result[j] = result[z];
		result[z] = temp;
	}
	
	public static int[] quickSort(int[] input, boolean fromSmallest, int firstIndex, int lastIndex) {

		int pivot = firstIndex;
		int[] result = input;

		if (fromSmallest) {
			int i = pivot;
			int value = result[pivot];
			for (int j = firstIndex + 1; j <= lastIndex; j++) {
				if (value > result[j]) {
					i++;
					swap(result, i, j);
					
				}
			}
			
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
	
	public static void main(String[] args) {
		
		comparCounter=0;
		Scanner reader = new Scanner(System.in);
		System.out.println("Podaj dlugoscc tablicy");
		length = reader.nextInt();
		if (length < 1) {
			System.out.println("Zly rozmiar");
			System.exit(0);
		}
		array = new int[length];
		
		System.out.println("Wpisz 1 jesli chcesz losowac tablice, 2 jesli wpisac");
		int option = reader.nextInt();
		if (option != 1 && option != 2 && option!=3) {
			System.out.println("Zly wybor");
			System.exit(0);
		}
		if(option==3){
			System.out.println("TAJNA OPCJA DLA STATYSTYK");
			Random rnd = new Random();
			int counter=1000;
			while(counter<=100000){
				array = new int[counter];
				for(int i=0;i<counter;i++){
					array[i]=rnd.nextInt(1000);
				}		
				value=array[0];
				array = quickSort(array, true, 0, counter-1);
				long startTime = System.nanoTime();
				int result = binarysearch(array,0,counter-1,value);
				long endTime = System.nanoTime();
				totalTime = endTime - startTime;
				counter+=1000;
				if(result == 1){
					System.out.println("ELEMENT " + value +" JEST W TABLICY --liczba porownan-- " + comparCounter + " --czas wykonania-- " + totalTime);
				}
				else
					System.out.println("NIE MA ELEMENTU W TABLICY --liczba porownan-- " + comparCounter + " --czas wykonania-- " + totalTime);
			}
			System.exit(0);
		} else if(option==1){
			Random rnd = new Random();
			for(int i=0;i<length;i++){
				array[i]=rnd.nextInt(1000);
			}		
			array = quickSort(array, true, 0, length-1);
		} else{
			System.out.println("Podaj tablice");
			for (int i = 0; i < length; i++) 
				array[i] = reader.nextInt();
			array = quickSort(array, true, 0, length-1);
		}
		
		for(int i=0;i<length;i++)
			System.out.print(array[i] + ", ");
		System.out.println("");
		
		System.out.println("Podaj poszukiwan wartosc");
		value = reader.nextInt();
		
		long startTime = System.nanoTime();
		int result = binarysearch(array,0,length-1,value);
		long endTime = System.nanoTime();
		totalTime = endTime - startTime;
		
		if(result == 1){
			System.out.println("ELEMENT " + value + " JEST W TABLICY --liczba porownan-- " + comparCounter + " --czas wykonania-- " + totalTime);
		}
		else
			System.out.println("NIE MA ELEMENTU " + value + " W TABLICY --liczba porownan-- " + comparCounter + " --czas wykonania-- " + totalTime);
	}

	private static int binarysearch(int[] array2,int start,int end,int value2 ) {
		int middle=start+(end-start+1)/2;
		comparCounter=comparCounter+2;
		if(middle < 0 || middle > end)
			return 0;
		comparCounter++;
		if(array2[middle] == value2)
			return 1;
		comparCounter++;
		if(start==end)
			return 0;
		comparCounter++;
		if(array2[middle]<value2)
			return binarysearch(array2, middle+1,end,value2);
		else
			return binarysearch(array2, start, middle-1, value2);
		
	}

}
