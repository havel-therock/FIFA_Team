import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.StringTokenizer;

public class Test {
	public void load(File file, Object struct,int s) {
		Scanner scan = null;
		BST bst = null;
		RBT rbt = null;
		if(s==1) {
			bst = (BST)struct;
		}
		else{
			rbt = (RBT)struct;
		}
		try {
			scan = new Scanner(file);
		} catch(FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		StringTokenizer token;
		while(scan.hasNextLine()) {
			token = new StringTokenizer(scan.nextLine()," ");
			while(token.hasMoreElements()) {
				if(s==1) {
					bst.insert(token.nextToken());
				}
				else{
					rbt.insert(token.nextToken());
				}
			}
		}
	}
	
	public static void main(String[] args){
		Test t = new Test();
		long millisActualTime;
		long executionTime;
		if(args[0].equals("--type")) {
			if(args[1].equals("bst")) {
				BST bst = new BST();
				switch(args[2]) {
				case "insert":
					millisActualTime = System.currentTimeMillis();
					bst.insert(args[3]);
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+bst.comparison);
					System.err.println("Przestawienia:"+bst.change);
					break;
				case "delete":
					millisActualTime = System.currentTimeMillis();
					bst.delete(args[3]);
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+bst.comparison);
					System.err.println("Przestawienia:"+bst.change);
					break;
				case "find":
					millisActualTime = System.currentTimeMillis();
					System.out.println(bst.find(args[3]));
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+bst.comparison);
					System.err.println("Przestawienia:"+bst.change);
					break;
				case "min":
					millisActualTime = System.currentTimeMillis();
					bst.min();
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+bst.comparison);
					System.err.println("Przestawienia:"+bst.change);
					break;
				case "max":
					millisActualTime = System.currentTimeMillis();
					bst.max();
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+bst.comparison);
					System.err.println("Przestawienia:"+bst.change);
					break;
				case "successor":
					millisActualTime = System.currentTimeMillis();
					bst.successor(args[3]);
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+bst.comparison);
					System.err.println("Przestawienia:"+bst.change);
					break;
				case "inorder":
					millisActualTime = System.currentTimeMillis();
					bst.inorder(bst.root);
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+bst.comparison);
					System.err.println("Przestawienia:"+bst.change);
					break;
				case "load":
					millisActualTime = System.currentTimeMillis();
					File file = new File(args[3]);
					t.load(file,bst,1);
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+bst.comparison);
					System.err.println("Przestawienia:"+bst.change);
					break;
				case "<./input":
					millisActualTime = System.currentTimeMillis();
					File f= new File("input");
					Scanner scan = null;
					int p=0;
					String command=null;
					try {
						scan = new Scanner(f);
					} catch(FileNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					StringTokenizer token;
					while(scan.hasNextLine()) {
						token = new StringTokenizer(scan.nextLine()," ");
						p=0;
						while(token.hasMoreElements()) {
							if(p==0) {
								command = token.nextToken();
								p=1;
								if(command.equals("min")) {
									bst.min();
								}
								else if(command.equals("max")) {
									bst.max();
								}
								else if(command.equals("inorder")) {
									bst.inorder(bst.root);
								}
							}
							else {
								switch(command) {
								case "insert":
									bst.insert(token.nextToken());
									break;
								case "delete":
									bst.delete(token.nextToken());
									break;
								case "find":
									System.out.println(bst.find(token.nextToken()));
									break;
								case "min":
									bst.min();
									break;
								case "max":
									bst.max();
									break;
								case "successor":
									bst.successor(token.nextToken());
									break;
								case "inorder":
									bst.inorder(bst.root);
									break;
								case "load":
									File fi = new File(token.nextToken());
									t.load(fi,bst,1);
									break;
								}
							}
						}
					}
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+bst.comparison);
					System.err.println("Przestawienia:"+bst.change);
					break;
				}
			}
			else if(args[1].equals("rbt")) {
				RBT rbt = new RBT();
				switch(args[2]) {
				case "insert":
					millisActualTime = System.currentTimeMillis();
					rbt.insert(args[3]);
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+rbt.comparison);
					System.err.println("Przestawienia:"+rbt.change);
					System.err.println("Przekolorowania:"+rbt.colorNr);
					break;
				case "delete":
					millisActualTime = System.currentTimeMillis();
					rbt.delete(args[3]);
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+rbt.comparison);
					System.err.println("Przestawienia:"+rbt.change);
					System.err.println("Przekolorowania:"+rbt.colorNr);
					break;
				case "find":
					millisActualTime = System.currentTimeMillis();
					System.out.println(rbt.find(args[3]));
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+rbt.comparison);
					System.err.println("Przestawienia:"+rbt.change);
					System.err.println("Przekolorowania:"+rbt.colorNr);
					break;
				case "min":
					millisActualTime = System.currentTimeMillis();
					rbt.min();
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+rbt.comparison);
					System.err.println("Przestawienia:"+rbt.change);
					System.err.println("Przekolorowania:"+rbt.colorNr);
					break;
				case "max":
					millisActualTime = System.currentTimeMillis();
					rbt.max();
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+rbt.comparison);
					System.err.println("Przestawienia:"+rbt.change);
					System.err.println("Przekolorowania:"+rbt.colorNr);
					break;
				case "successor":
					millisActualTime = System.currentTimeMillis();
					rbt.successor(args[3]);
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+rbt.comparison);
					System.err.println("Przestawienia:"+rbt.change);
					System.err.println("Przekolorowania:"+rbt.colorNr);
					break;
				case "inorder":
					millisActualTime = System.currentTimeMillis();
					rbt.inorder(rbt.root);
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+rbt.comparison);
					System.err.println("Przestawienia:"+rbt.change);
					System.err.println("Przekolorowania:"+rbt.colorNr);
					break;
				case "load":
					millisActualTime = System.currentTimeMillis();
					File file = new File(args[3]);
					t.load(file,rbt,1);
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+rbt.comparison);
					System.err.println("Przestawienia:"+rbt.change);
					System.err.println("Przekolorowania:"+rbt.colorNr);
					break;
				case "<./input":
					millisActualTime = System.currentTimeMillis();
					File f= new File("input");
					Scanner scan = null;
					int p=0;
					String command=null;
					try {
						scan = new Scanner(f);
					} catch(FileNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					StringTokenizer token;
					while(scan.hasNextLine()) {
						token = new StringTokenizer(scan.nextLine()," ");
						p=0;
						while(token.hasMoreElements()) {
							if(p==0) {
								command = token.nextToken();
								p=1;
							}
							else {
								switch(command) {
								case "insert":
									rbt.insert(token.nextToken());
									break;
								case "delete":
									rbt.delete(token.nextToken());
									break;
								case "find":
									rbt.find(token.nextToken());
									break;
								case "min":
									rbt.min();
									break;
								case "max":
									rbt.max();
									break;
								case "successor":
									rbt.successor(token.nextToken());
									break;
								case "inorder":
									rbt.inorder(rbt.root);
									break;
								case "load":
									File fi = new File(token.nextToken());
									t.load(fi,rbt,2);
									break;
								}
							}
						}
					}
					executionTime = System.currentTimeMillis() - millisActualTime;
					System.err.println("Czas:"+executionTime);
					System.err.println("Porownania:"+rbt.comparison);
					System.err.println("Przestawienia:"+rbt.change);
					System.err.println("Przekolorowania:"+rbt.colorNr);
					break;
				}
			}
		}
	}
}
