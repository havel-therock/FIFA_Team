

import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;


public class Decipher {

    static int size = 20;
    static int max;

    public static void main(String[] args) {

        String[][] arrayOfBinaryCrypts = null;

        try {
            arrayOfBinaryCrypts = read(size);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        Xorer xorer = new Xorer();
        int[][] counter = new int[size][max];
        for (int i = 0; i < size; i++) {
            for (int z = 0; z < max; z++) {
                counter[i][z] = 0;
            }
        }

        //Wypelnianie tablicy counter [ilosc kryptogramow][maks ilosc bajtow]
        for (int i = 0; i < arrayOfBinaryCrypts.length; i++) {

            for (int j = 0; j < arrayOfBinaryCrypts.length; j++) {
                if (!(i == j)) {
                    String[] xorResult = xorer.encode(arrayOfBinaryCrypts[i], arrayOfBinaryCrypts[j]);

                    for (int k = 0; k < xorResult.length; k++) {
                        //System.out.println(xorResult[k]);
                        if (xorResult[k].startsWith("01")) {
                            counter[i][k]++;
                            counter[j][k]++;
                        }
                    }
                }
            }
        }
        //Zapisywanie bajtow-kandydatow na spacje
        ArrayList<ArrayList<String>> listsOfCandidates = new ArrayList<ArrayList<String>>();
        for (int i = 0; i < max; i++) {
            listsOfCandidates.add(new ArrayList<String>());
        }
        for (int i = 0; i < max; i++) {
            int max2 = 0;
            for (int j = 0; j < size; j++) {
                if (counter[j][i] > max2) {
                    max2 = counter[j][i];
                }
            }
            for (int j = 0; j < size; j++) {
                if (counter[j][i] == max2 && max2 != 0 && arrayOfBinaryCrypts[j].length > i) {
                    listsOfCandidates.get(i).add(arrayOfBinaryCrypts[j][i]);
                }
            }
        }
        //xorowanie kandydatow na spacje ze spacja
        for (int i = 0; i < listsOfCandidates.size(); i++) {
            for (int j = 0; j < listsOfCandidates.get(i).size(); j++) {
                listsOfCandidates.get(i).set(j, xorer.encode(listsOfCandidates.get(i).get(j), "00100000"));
            }
        }
        //wybieranie najczestszych kandydatow na klucz
        HashMap<Integer, String> findKey = new HashMap();
        for (int i = 0; i < listsOfCandidates.size(); i++) {
            Map<String, Integer> stringsCount = new HashMap<>();
            for (String s : listsOfCandidates.get(i)) {
                Integer c = stringsCount.get(s);
                if (c == null) {
                    c = new Integer(0);
                }
                c++;
                stringsCount.put(s, c);
            }
            Map.Entry<String, Integer> mostRepeated = null;
            for (Map.Entry<String, Integer> e : stringsCount.entrySet()) {
                if (mostRepeated == null || mostRepeated.getValue() < e.getValue()) {
                    mostRepeated = e;
                }
            }
            if (mostRepeated != null) {
                findKey.put(i, mostRepeated.getKey());
            }
        }
        //zbieranie klucza
        String[] key = new String[max];
        for (int i = 0; i < max; i++) {
            key[i] = findKey.get(i);
        }

        //xorowanie klucza z wiadomosciami
        ArrayList<String[]> binaryResults = new ArrayList<String[]>();
        for (int i = 0; i < size; i++) {
            binaryResults.add(new String[arrayOfBinaryCrypts[i].length]);
        }
        for (int i = 0; i < size; i++) {
            for (int g = 0; g < arrayOfBinaryCrypts[i].length; g++) {
                if (key[g] != null) {
                    binaryResults.get(i)[g] = xorer.encode(arrayOfBinaryCrypts[i][g], key[g]);
                } else {
                    binaryResults.get(i)[g] = "*";
                }
            }
        }

        //konwertowanie bin na ascii i czytanie wynikow
        System.out.println("KLUCZ : " + xorer.convertbinToString(key));
        for (int i = 0; i < size; i++) {
            System.out.println("WIADOMOSC " + (i + 1) + " : " + xorer.convertbinToString(binaryResults.get(i)) + "\n");
        }

         Scanner scan = new Scanner(System.in);
        int option = 0;

        while (option >= 0) {
            System.out.println("Hello");
            int w1 = 0, w2 = 60;
            System.out.println("-------------MENU-------------------");
            System.out.println("Wybierz opcje:");
            System.out.println("1.Guess letter");
            System.out.println("2.Wczytaj ponownie tekst ");
            System.out.println("3.Zobacz cały tekst");
            System.out.println("4.-----------Exit-----------");

            System.out.println("Message ->" + (xorer.convertbinToString(binaryResults.get(0))).substring(w1, w2));
            System.out.println("Numbers ->" + "01234567890123456789012345678901234567890123456789012346789");
            System.out.println("           " + "|   +0    |   +1    |   +2    |   +3    |   +4    |   +5  |");
            option = scan.nextInt();
            switch (option) {
                case 1: {
                    while (option > 0) {

                        System.out.println("Which message ? (1-20):");
                        int msg = scan.nextInt();
                        scan.nextLine();

                        System.out.println("Message ->" + (xorer.convertbinToString(binaryResults.get(msg))).substring(w1, w2));
                        System.out.println("Numbers ->" + "01234567890123456789012345678901234567890123456789012346789");
                        System.out.println("          " + "|   +0    |   +1    |   +2    |   +3    |   +4    |   +5   |");

                        if (option == 9) {
                            w2 += w2 + 60 > (xorer.convertbinToString(binaryResults.get(msg)).length()) ? (xorer.convertbinToString(binaryResults.get(msg)).length()) - w2 : 60;
                            w1 += 60;
                        }
                        System.out.println("Enter number where can u start " + "(" + w1 + " , " + w2 + "):");
                        int index = scan.nextInt();
                        scan.nextLine();
                        System.out.println("What is the text ? ");
                        String letter = scan.nextLine();
                        byte[] bytes = letter.getBytes();
                        StringBuilder binary = new StringBuilder();
                        int it = 0;
                        for (byte b : bytes) {
                            int val = b;
                            for (int i = 0; i < 8; i++) {
                                binary.append((val & 128) == 0 ? 0 : 1);
                                val <<= 1;
                            }
                            String m = xorer.encode(arrayOfBinaryCrypts[0][index], binary.toString());
                            key[index] = m;
                            index++;
                            binary = new StringBuilder();
                        }
                        System.out.println(" dodano tekst !");
                        System.out.println("Wybierz opcje: ");
                        System.out.println("1. Przesuń w prawo (odgadni kolejny tekst)");
                        System.out.println("2. Back to menu");
                        option = scan.nextInt();
                        scan.nextLine();
                        option = option == 2 ? 0 : 9;
                        break;
                    }
                }
                case 2: {
                    for (int i = 0; i < size; i++) {
                        for (int g = 0; g < arrayOfBinaryCrypts[i].length; g++) {
                            if (key[g] != null) {
                                binaryResults.get(i)[g] = xorer.encode(arrayOfBinaryCrypts[i][g], key[g]);
                            } else {
                                binaryResults.get(i)[g] = "*";
                            }
                        }
                    }
                    break;
                }
                case 3: {
                    for (int i = 0; i < size; i++) {
                        for (int g = 0; g < arrayOfBinaryCrypts[i].length; g++) {
                            if (key[g] != null) {
                                binaryResults.get(i)[g] = xorer.encode(arrayOfBinaryCrypts[i][g], key[g]);
                            } else {
                                binaryResults.get(i)[g] = "*";
                            }
                        }
                    }
                    System.out.println("Key : " + xorer.convertbinToString(key));
                    for (int i = 0; i < size; i++) {
                        System.out.println("Message " + (i + 1) + " : " + xorer.convertbinToString(binaryResults.get(i)) + "\n");
                    }
                    break;
                }
                case 4: {
                    option = -1;
                    break;
                }
                default:
                    break;

            }

        }

    }

    public static String[][] read(int size) throws FileNotFoundException {
        String[] txtArray = new String[size];
        Scanner sc;
        String txt;
        int i = 0;
        sc = new Scanner(new File("kody.txt"));
        while (sc.hasNext()) {
            txt = sc.nextLine();
            if (!txt.isEmpty() && !txt.startsWith("kryptogram")) {
                txtArray[i] = txt;
                i++;
            }
        }
        max = 0;
        String[][] c = new String[size][];
        for (int g = 0; g < size; g++) {
            c[g] = new String[((txtArray[g].length() + 1) / 9)];
            if (((txtArray[g].length() + 1) / 9) > max) {
                max = ((txtArray[g].length() + 1) / 9);
            }
        }
        for (int g = 0; g < size; g++) {
            putByteInArray(c[g], txtArray[g]);
        }
        return c;
    }

    public static void putByteInArray(String[] c, String txt) {

        int j = 0;

        for (int i = 0; i < txt.length() - 1; i += 9) {
            //   System.out.println(txt.length() + " " + i);
            String output = txt.substring(i, (i + 8));
            c[j] = output;
            j++;
        }
    }

}

