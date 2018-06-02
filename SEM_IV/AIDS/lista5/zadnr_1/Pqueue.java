import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;

public class Pqueue {
	
	Element [] a;
	int heapsize;
	
	Pqueue(int M){
		a = new Element[M];
		heapsize=0;
	}
	
	public void insert(int x,double p){
		int i = heapsize;
		heapsize++;
		while(i>0 && a[i/2].getP()>p){
			a[i]=a[i/2];
			i=i/2;
		}
		a[i]= new Element(x, p);
	}
	
	public int empty(){
		if (heapsize==0)
			return 0;
		else
			return 1;			
	}
	
	public int top(){
		if(this.empty()==1)
			return a[0].getV();
		else
			return 0;
	}
	
	public void topp(){
		int w=top();
		if (w!=0)
			System.out.println(w);
	}
	
	public int pop(){
		if(this.empty()==1){
			int temp = a[0].getV();
			a[0] = a[heapsize-1];
			heapsize--;
			heapify(0);
			return temp;
		}
		else
			return 0;
	}
	
	public void popp(){
		int w = pop();
		if (w!=0)
			System.out.println(w);
	}
	
	private void heapify(int i) {
		int l=2*i;
		int r=l+1;
		if(l<heapsize){
			if(r<heapsize){
				if (a[r].getP()>a[l].getP()){
					if (a[i].getP()>a[l].getP()){
						Element temp=a[i];
						a[i]=a[l];
						a[l]=temp;
						heapify(l);
					}
				} else if (a[i].getP()>a[r].getP()){
					Element temp=a[i];
					a[i]=a[r];
					a[r]=temp;
					heapify(r);
				}
			} else {
				if (a[i].getP()>a[l].getP()){
					Element temp=a[i];
					a[i]=a[l];
					a[l]=temp;
					heapify(l);
				}					
			}
		} 
			
				
		
	}
	public Boolean isThere(int x){
		for(int i=0;i<heapsize;i++)
			if(a[i].getV()==x)
				return true;
		return false;
			
	}
	
	public double getP(int x){
		for(int i=0;i<heapsize;i++)
			if(a[i].getV()==x)
				return a[i].getP();
		return -1;
			
	}
	
	public void priority(int x, double p){
		for(int i=0;i<heapsize;i++)
			if(a[i].getV()==x){
				if(a[i].getP()>p){
					a[i].setP(p);
					int parent = i/2;
					Element temp=a[parent];
					int me=i;
					while(temp.getP()>a[me].getP()){
						a[parent]=a[me];
						a[me]=temp;
						me=parent;
						parent=parent/2;
						temp=a[parent];
					}
				}
			}
	}
	
	public void print(){
		for(int i=0;i<heapsize;i++)
			System.out.print("(" + a[i].getV() + "," + a[i].getP() + ") , ");
		System.out.println();			
	}
	
	 public static void main(String[] args) {
		 System.out.println("Hello, write the number operations");
		 Scanner reader = new Scanner(System.in);
			int operationsNumber = reader.nextInt();
			Pqueue queue = new Pqueue(operationsNumber);
			String[] command;
			command = reader.nextLine().split(" ");
			
			while(operationsNumber>0){
				command = reader.nextLine().split(" ");
				if(command.length!=2 && command.length!=1 && command.length!=3){
					System.err.println("error");
					System.exit(0);
				}
				switch (command[0]) {
				case "insert":
					queue.insert(Integer.parseInt(command[1]), Integer.parseInt(command[2]));
					System.out.println();
					break;
				case "empty":
					queue.empty();
					System.out.println();
					break;
				case "top":
					queue.topp();
					System.out.println();
					break;
				case "pop":
	                queue.popp();
	                System.out.println();
	                break;
	            case "priority":
	            	queue.priority(Integer.parseInt(command[1]), Integer.parseInt(command[2]));
	                System.out.println();
	                break;
	            case "print":
	                queue.print();
	                System.out.println();
	                break;
				}
				operationsNumber--;
			}
			
	 }
}

class Element{
	
	private int value;
	private double priority;
	
	Element (int v, double p){
		value=v;
		priority=p;
	}
	
	public int getV (){
		return value;
	}
	
	public double getP (){
		return priority;
	}
	
	public void setP (double p){
		priority=p;
	}
}

class Edge{
	int v1;
	int v2;
	double w;
	public Edge(int v1, int v2, double w) {
		this.v1=v1;
		this.v2=v2;
		this.w=w;
	}
}