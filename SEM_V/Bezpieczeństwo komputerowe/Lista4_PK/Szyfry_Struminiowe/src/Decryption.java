import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Decryption extends  Transform{
    ArrayList<String> c = new ArrayList(); //lista kryptogramow
    int c_num = 20; //liczba kryptogramow

    //odczytuje kryptogramy z plikow do tablicy
    public void readC() throws FileNotFoundException {
        Scanner sc;
        String txt;
        for(int i=1;i<=c_num;i++) {
            sc = new Scanner(new File("kr/kr"+i+".txt"));
            txt = sc.nextLine();
            c.add(txt);
        }
    }

    public void compare(){
        ArrayList<String> sign = sngleSign(c,1);
        int ascii_num;
        int calc=0;

        for(int j=0;j<256;j++) {
            for (int i = 0; i < c_num; i++) {
                ascii_num = Integer.parseInt(xor(sign.get(i), key), 2);
                if ((ascii_num >= 65 && ascii_num <= 90) || (ascii_num >= 97 && ascii_num <= 122) || (ascii_num >= 48 && ascii_num <= 57)) {
                    //System.out.println(i + 1 + ":   " + (char) ascii_num);
                    calc++;
                }
            }
            if(calc==20){
                System.out.println(key);
                System.out.println(calc);
            }
            next_key();
            calc = 0;
        }
    }

    public static void main(String[] args) {
        Decryption d = new Decryption();

        try {
            d.readC();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        d.compare();

        ArrayList<String> sign = d.sngleSign(d.c,1);
        d.key = "10000000";
        System.out.println(d.key);
        for(int i=0;i<d.c_num;i++){
            System.out.println(i + 1 + ":   " + (char) Integer.parseInt(d.xor(sign.get(i), d.key), 2));
        }
        d.key = "10001110";
        System.out.println(d.key);
        for(int i=0;i<d.c_num;i++){
            System.out.println(i + 1 + ":   " + (char) Integer.parseInt(d.xor(sign.get(i), d.key), 2));
        }
        d.key = "10001111";
        System.out.println(d.key);
        for(int i=0;i<d.c_num;i++){
            System.out.println(i + 1 + ":   " + (char) Integer.parseInt(d.xor(sign.get(i), d.key), 2));
        }
    }
}
