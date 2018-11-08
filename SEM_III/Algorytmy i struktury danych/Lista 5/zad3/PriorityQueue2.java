import java.util.Scanner;

public class PriorityQueue2 {
    QueueElement2 queue[];
    int queueSize;

    PriorityQueue2(int M){
        queue = new QueueElement2[M];
        queueSize = -1;
    }

    public void insert(int x,int y,double p){
        queueSize++;
        int i = queueSize;

        while(i>0 && queue[i/2].priority>p){
            queue[i] = queue[i / 2];
            i = i / 2;
        }
        queue[i] = new QueueElement2(x,y,p);
    }

    public int empty(){
        if(queueSize==-1){
            return 1;
        }
        else{
            return 0;
        }
    }

    public void heapify(int i){
        int l = 2*i;
        int r = 2*i+1;
        int smalestPriorityIndex=i;
        QueueElement2 tmp;
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

    public QueueElement2 pop(){
        QueueElement2 tmp;
        if(this.empty()==0){
            tmp = queue[0];
            queue[0] = queue[queueSize];
            queueSize--;
            heapify(0);
            return tmp;
        }
        else{
            return null;
        }
    }
}
