import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;

public class Builder {

	static DataStructure struct;
	
	public static void main(String[] args) {
		int linsert = 0, ldelete = 0, lfind = 0, lmin = 0, lmax = 0, lsuccessor = 0, linorder = 0, lload = 0,mxcount=0,count=0;
		if((args.length==4 || args.length==2) && args[0].equals("--type")){
			switch (args[1]) {
			case "bst":
				struct = new BST();
				break;
			case "rbt":
				struct = new RBT();
				break;
			case "hmap":
				struct = new Hmap();
				break;
			}
			
		}
		long startTime = System.nanoTime();
		/*
		struct.max();
		System.out.println();
		struct.insert("aaa");
		System.out.println();
		struct.insert("a");
		System.out.println();
		struct.insert("b");
		System.out.println();
		struct.insert("ab");
		System.out.println();
		struct.inorder();
		System.out.println();
		struct.delete("a");
		System.out.println();
		struct.delete("b");
		System.out.println();
		struct.max();
		struct.load("sample.txt");
		System.out.println();
		struct.find("three");
		System.out.println();
		struct.delete("three");
		System.out.println();
		struct.find("three");
		System.out.println();
		struct.find("Three");
		System.out.println();
		struct.inorder();
		struct.delete("Three");
		System.out.println();
		struct.inorder();
		struct.find("Three");
		System.out.println();
		struct.min();
		System.out.println();
		*/
	//	struct.inorder();
		Scanner reader = new Scanner(System.in);
		int operationsNumber = reader.nextInt();
		String[] command;
		command = reader.nextLine().split(" ");
		
		while(operationsNumber>0){
			command = reader.nextLine().split(" ");
			if(command.length!=2 && command.length!=1){
				System.err.println("error");
				System.exit(0);
			}
			switch (command[0]) {
			case "insert":
				long sTime = System.nanoTime();
                struct.insert(command[1].replaceAll("[^a-zA-Z]", ""));
                long eTime = System.nanoTime();
                long tTime = eTime - sTime;
                System.err.println("Time " + tTime);
                linsert++;
                count++;
                if(struct.size>mxcount)
                	mxcount=struct.size;
				System.out.println();
				break;
			case "load":
				sTime = System.nanoTime();
                struct.load(command[1]);
                eTime = System.nanoTime();
                tTime = eTime - sTime;
                System.err.println("Time " + tTime);
                lload++;
				System.out.println();
				break;
			case "delete":
				 ldelete++;
                 sTime = System.nanoTime();
                 struct.delete(command[1]);
                 eTime = System.nanoTime();
                 tTime = eTime - sTime;
                 count--;
                 System.err.println("Time " + tTime);
				System.out.println();
				break;
			case "find":
				sTime = System.nanoTime();
                struct.find(command[1]);
                eTime = System.nanoTime();
                tTime = eTime - sTime;
                System.err.println("\nTime " + tTime);
                lfind++;
				System.out.println();
				break;
			case "min":
                lmin++;
                struct.min();
                System.out.println();
                break;
            case "max":
                lmax++;
                struct.max();
                System.out.println();
                break;
            case "successor":
                lsuccessor++;
                struct.successor(command[1]);
                System.out.println();
                break;
            case "inorder":
                linorder++;
                struct.inorder();
                System.out.println();
                break;
            case "test":
                String[] strings = null;
                String output = "";
                try {
                    BufferedReader bf = new BufferedReader(new FileReader("test.txt"));
                    String text = " ";

                    String line;
                    while ((line = bf.readLine()) != null) {
                        struct.insert(line.replaceAll("[^a-zA-Z]", ""));
                        text += line.replaceAll("[^a-zA-Z]", "") + " ";
                    }
                    System.out.println("Wczytane");
                    strings = text.split(" ");
                    bf.close();
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                sTime = System.currentTimeMillis();
                for (String s : strings) {
                    struct.find(s);
                    struct.delete(s);
                    struct.find(s);
                }
                eTime = System.currentTimeMillis();
                tTime = eTime - sTime;
                output = "Array size " + Hmap.arraySize + "\n";
                output += "Rbt to link " + Hmap.toLink + "\n";
                output += "Link to rbt " + Hmap.toRBT + "\n";
                output += "Time " + tTime + "ms\n";

                System.out.println("Time " + tTime + "ms");
                try (PrintWriter out = new PrintWriter("output.txt")) {
                    out.println(output);
                } catch (FileNotFoundException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
                break;

            case "test2":
                for (int i = 1; i < 10000; i*=10) {
                       struct = new Hmap();
                       Hmap.toLink=i;
                       Hmap.toRBT=i*2;
                       System.out.println("i "+i);
                
                 sTime = System.currentTimeMillis();
                try {
                    BufferedReader bf = new BufferedReader(new FileReader("test.txt"));

                    String line;
                    while ((line = bf.readLine()) != null) {
                        struct.insert(line.replaceAll("[^a-zA-Z]", ""));
                    }
                    System.out.println("Wczytane");
                    bf.close();
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                struct.find("cat");
                struct.find("dog");
                struct.find("horde");
                struct.find("horse");
                struct.find("sam");
                eTime = System.currentTimeMillis();
                tTime = eTime - sTime;
                System.out.println("Time " + tTime + "ms");
                }
                break;
			}
			operationsNumber--;
		}
		long endTime = System.nanoTime();
        long totalTime = endTime - startTime;
        System.err.println("Czas :" + totalTime + "ms");
        System.err.println("Insert :" + linsert);
        System.err.println("delete :" + ldelete);
        System.err.println("Load :" + lload);
        System.err.println("Find :" + lfind);
        System.err.println("Max :" + lmax);
        System.err.println("Min :" + lmin);
        System.err.println("successor :" + lsuccessor);
        System.err.println("Inorder :" + linorder);
        System.err.println("max liczba elem :" + mxcount);
        System.err.println("koncowa liczba elem :" + struct.size);
	}

}
