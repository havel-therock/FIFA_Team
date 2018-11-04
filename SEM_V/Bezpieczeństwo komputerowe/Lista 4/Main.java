import java.util.Scanner;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;


public class Main {

    public static String readFile(String source) {
        FileReader fr = null;
        String buffer = "";
        // OTWIERANIE PLIKU:
        try {
            fr = new FileReader(source);
        } catch (FileNotFoundException e) {
            System.out.println("BLAD PRZY OTWIERANIU PLIKU!");
            System.exit(1);
        }

        BufferedReader bfr = new BufferedReader(fr);
        String line = "";
        // ODCZYT KOLEJNYCH LINII Z PLIKU:
        try {
            while((line = bfr.readLine()) != null ){
                buffer += line;
                System.out.println(buffer);
            }
        } catch (IOException e) {
            System.out.println("BLAD ODCZYTU Z PLIKU!");
            System.exit(2);
        }

        // ZAMYKANIE PLIKU
        try {
            fr.close();
        } catch (IOException e) {
            System.out.println("BLAD PRZY ZAMYKANIU PLIKU!");
            System.exit(3);
        }
        return buffer;
    }



    public static void main(String[] args) {

        char possibleChars[] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'W', 'V', 'X', 'Y', 'Z', 'Q',
                            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'o', 'r', 's', 't', 'u', 'w', 'v', 'x', 'y', 'z', 'q', ' '};
        char possibleCharsXored[] = {'A'^32, 'B'^32, 'C'^32, 'D'^32, 'E'^32, 'F'^32, 'G'^32, 'H'^32, 'I'^32, 'J'^32, 'K'^32, 'L'^32, 'M'^32, 'N'^32, 'O'^32, 'P'^32, 'R'^32, 'S'^32, 'T'^32, 'U'^32, 'W'^32, 'V'^32, 'X'^32, 'Y'^32, 'Z'^32, 'Q'^32,
                                 'a'^32, 'b'^32, 'c'^32, 'd'^32, 'e'^32, 'f'^32, 'g'^32, 'h'^32, 'i'^32, 'j'^32, 'k'^32, 'l'^32, 'm'^32, 'n'^32, 'o'^32, 'o'^32, 'r'^32, 's'^32, 't'^32, 'u'^32, 'w'^32, 'v'^32, 'x'^32, 'y'^32, 'z'^32, 'q'^32, ' '^32};
        
        Scanner scan = new Scanner(System.in);
        System.out.print("Jak duzo zaszyfrowanych wiadomosci odczytac (MAX:20)? -> ");
        int numberOfCibhers = scan.nextInt();
        // System.out.println(numberOfCibhers);

        String[] ciphersH = new String[numberOfCibhers];
        String fileName = "";
        char[][] ciphers = new char[numberOfCibhers][];

        String cipher = readFile("deszyfr.txt");
        String[] cipherToDec = cipher.split(" ");
        for(int i = 0; i < cipherToDec.length; i++) {
            int numberDec = Integer.parseInt(cipherToDec[i], 2);
            cipherToDec[i] = Integer.toString(numberDec);
            // System.out.println(cipherToDec[i]);
        }

        int numDec = 0;
        for (int i=0; i < numberOfCibhers; i++) {
            int x = i+1;
            fileName = "c"+ x +".txt";
            System.out.println(fileName);
            ciphersH[i] = readFile(fileName);
            String[] ciphersToDec = ciphersH[i].split(" ");
            // System.out.println(ciphersToDec.length);
            ciphers[i] = new char[ciphersToDec.length];
            for(int j = 0; j < ciphersToDec.length; j++) {
                numDec = Integer.parseInt(ciphersToDec[j], 2);
                // ciphers[i][j] = Integer.toString(numDec);
                ciphers[i][j] = (char)(numDec);
                System.out.println(ciphers[i][j]); 
            }
            // System.out.println(ciphers[i]);
        }
            
        System.out.println("\n");
        System.out.println("Zaczynamy:");
        // System.out.println(ciphers.length);
        
        for(int i = 0; i < cipherToDec.length; i++) {
            int key = 0;
            int lastMax = 0;
            for(int k = 0; k < ciphers.length; k++) {
                int counter = 0;
    
                for(int j = 0; j < ciphers.length; j++) {
                    char cip1 = ciphers[j][i];
                    char cip2 = ciphers[k][i];
                    int xor_value = cip1^cip2;
                    if (xor_value >= 64) counter++;
                }
    
                if (counter > 12) {
                    if (counter > lastMax) {
                        lastMax = counter;
                        char cipK = ciphers[k][i];
                        char empty = ' ';
                        key = cipK^empty;
                    }
                }
            }
            if (key != 0) {
                int s = Integer.parseInt(cipherToDec[i]);
                int xoredChar = key^s;
                System.out.print((char)(xoredChar));
            } else {
                System.out.print("*");
            }
        }
        
    }
}