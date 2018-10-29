import java.io.File;
import java.util.Scanner;
import java.io.FileNotFoundException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Filtr {
    public String regex = "http.cookie";

    public Scanner read() throws FileNotFoundException{
        File f = new File("JSONfile");
        Scanner scan = new Scanner(f);
        return scan;
    }

    public String getCoockie() throws FileNotFoundException{
        String a = "";
        Scanner scan = read();
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(scan.nextLine());
        while(!matcher.find()) {
            a = scan.nextLine();
            matcher = pattern.matcher(a);
        }
        return a;
    }

    public static void main(String [ ] args)throws FileNotFoundException{
        Filtr f = new Filtr();
        System.out.println(f.getCoockie());
    }
}
