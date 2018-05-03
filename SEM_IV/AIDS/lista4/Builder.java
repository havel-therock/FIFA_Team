import java.util.Scanner;

public class Builder {

	static DataStructure struct;
	
	public static void main(String[] args) {
		if((args.length==4 || args.length==2) && args[0].equals("--type")){
			switch (args[1]) {
			case "bst":
				struct = new BST();
				break;
			case "rbt":
				struct = new BST();
				break;
			case "hmap":
				struct = new BST();
				break;
			}
			
		}
		
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
				struct.insert(command[1]);
				System.out.println();
				break;
			case "load":
				struct.load(command[1]);
				System.out.println();
				break;
			case "delete":
				struct.delete(command[1]);
				System.out.println();
				break;
			case "find":
				struct.find(command[1]);
				System.out.println();
				break;
			case "min":
				struct.min();
				System.out.println();
				break;
			case "max":
				struct.max();
				System.out.println();
				break;
			case "successor":
				//struct.successor(command[1]);
				System.out.println();
				break;
			case "inorder":
				struct.inorder();
				System.out.println();
				break;
			}
			operationsNumber--;
		}
			
	}

}
