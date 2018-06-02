import java.util.Scanner;

public class PriorityQueue {
    QueueElement queue[];
    int queueSize;

    PriorityQueue(int M){
        queue = new QueueElement[M];
        queueSize = -1;
    }

    public void insert(int x, double p){
        queueSize++;
        int i = queueSize;

        while(i>0 && queue[i/2].priority>p){
                queue[i] = queue[i / 2];
                i = i / 2;
        }
        queue[i] = new QueueElement(x,p);
    }

    public int empty(){
        if(queueSize==-1){
            return 1;
        }
        else{
            return 0;
        }
    }

    public void top(){
        if(queueSize!=-1){
            System.out.println(queue[0].value);
        }
        else{
            System.out.println();
        }
    }

    public void heapify(int i){
        int l = 2*i;
        int r = 2*i+1;
        int smalestPriorityIndex=i;
        QueueElement tmp;
        if(i==0){
            l=1;
            r=2;
        }
        if(l<queueSize){
            if(r<queueSize){
                if(queue[r].priority<queue[l].priority){
                    tmp = queue[r];
                    queue[r] = queue[l];
                    queue[l] = tmp;
                    heapify(l);
                    heapify(r);
                }
                if(queue[r].priority<queue[l].priority && queue[r].priority<queue[i].priority){
                    smalestPriorityIndex = r;
                }
                else if(queue[l].priority<queue[i].priority && queue[l].priority<queue[r].priority){
                    smalestPriorityIndex = l;
                }
                else if(queue[i].priority<queue[r].priority && queue[i].priority<queue[l].priority){
                    smalestPriorityIndex = i;
                }
            }
            else{
                if(queue[i].priority<queue[l].priority){
                    smalestPriorityIndex = i;
                }
                else{
                    smalestPriorityIndex = l;
                }
            }
        }
        if(smalestPriorityIndex!=i){
            tmp = queue[i];
            queue[i] = queue[smalestPriorityIndex];
            queue[smalestPriorityIndex] = tmp;
            heapify(smalestPriorityIndex);
        }
    }

    public void pop(){
        if(this.empty()==0){
            System.out.println(queue[0].value);
            queue[0] = queue[queueSize];
            queueSize--;
            heapify(0);
        }
        else{
            System.out.println();
        }
    }

    public int popInt(){
        if(this.empty()==0){
            int v = queue[0].value;
            queue[0] = queue[queueSize];
            queueSize--;
            heapify(0);
            return v;
        }
        else{
            return -1;
        }
    }

    public void priority(int x,double p){
        for(int i=0;i<queueSize;i++){
            if(i*2<queueSize && p>queue[i*2].priority){
                i = i*2;
            }
            else{
                if(queue[i].value==x){
                    queue[i].priority = p;
                    if(queue[i].priority<=queue[i/2].priority) {
                        heapify(i / 2);
                    }
                }
            }
        }
    }

    public void print(){
        for(int i=0;i<=queueSize;i++){
            System.out.print("("+queue[i].value+","+queue[i].priority+")");
        }
        System.out.println();
    }


    public static void main(String [] args){
        Scanner scan = new Scanner(System.in);
        String command;
        String[] com = null;
        int M;
        System.err.println("Podaj liczbe operacji");
        M = Integer.parseInt(scan.nextLine());
        PriorityQueue pq = new PriorityQueue(M);
        while(M>0){
            command = scan.nextLine();
            com = command.split(" ");
            switch(com[0]){
                case "insert":
                    pq.insert(Integer.parseInt(com[1]),Double.parseDouble(com[2]));
                    break;
                case "empty":
                    System.out.println(pq.empty());
                    break;
                case "top":
                    pq.top();
                    break;
                case "pop":
                    pq.pop();
                    break;
                case "priority":
                    pq.priority(Integer.parseInt(com[1]),Double.parseDouble(com[2]));
                    break;
                case "print":
                    pq.print();
                    break;
                default:
                    System.err.println("Zle polecenie");
            }
            M--;
        }
    }
}
