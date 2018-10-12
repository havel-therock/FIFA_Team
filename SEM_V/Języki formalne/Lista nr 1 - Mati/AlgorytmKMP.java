import java.util.Scanner;

/**
 * 
 * @author Mateusz Laskowski
 */

 public class AlgorytmKMP {
    public static void main(String[] args) {
        String wzorzec, tekst_wejsciowy;
        int t,w,x,i,j;
        int next[] = new int[5];
        boolean stan = false;

        Scanner scanner = new Scanner(System.in);
        System.out.println("Length: " + next.length);
        System.out.println("Tekst wejsciowy:");
        tekst_wejsciowy = scanner.nextLine();
        System.out.println("Wzorzec:");
        wzorzec = scanner.nextLine();
        t = tekst_wejsciowy.length();
        w = wzorzec.length();

        if(w > next.length) {
            System.out.printf("ERROR: Max length wzorzec -> %d", next.length);
            return;
        }  
        
        
        // Obliczanie tablicy next
        next[0] = 0;
        next[1] = 0;
        x = 0;
        for(i = 2; i <= w; i++) {
            while(x > 0 && wzorzec.charAt(x) != wzorzec.charAt(i-1)) {
                x = next[x];
            }
            if(wzorzec.charAt(x) == wzorzec.charAt(i-1)) {
                x++;
            }
            next[i] = x;
        }

        // Algorytm
        i = 1;
        j = 0;
        while(i <= t-w+1) {
            j = next[j];
            while(j < w && wzorzec.charAt(j) == tekst_wejsciowy.charAt(i+j-1)) {
                j++;
            }
            if(j == w) {
                System.out.println("Index -> " + i);
                stan = true;
            }
            i = i+Math.max(1, j-next[j]);
        }

        if(stan) {
            System.out.println("TRUE");
            return;
        }
        else {
            System.out.println("FALSE");
            return;
        }

    }

 }