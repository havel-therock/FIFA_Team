
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

/**
 *
 * @author jakub
 */
public class Structure {

    public Structure() {
    }

    public void insert(String s) {

    }

    public void load(String f) {
        BufferedReader reader;
        try {
            reader = new BufferedReader(new FileReader(f));

            String line;
            while ((line = reader.readLine()) != null) {
                for (String s : line.split("\\s+")) {
                    insert(s.replaceAll("[^a-zA-Z]", ""));
                }
                // System.out.println();
            }
            System.out.println("Wczytano");
            reader.close();
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void delete(String s) {
    }

    public void find(String s) {
    }

    public void min() {
        System.out.println("");
    }

    public void max() {
        System.out.println("");
    }

    public void successor(Object k) {
        System.out.println("");
    }

    public void inorder() {
        System.out.println("");
    }

}
