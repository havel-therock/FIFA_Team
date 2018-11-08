#include <cstdio>
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <string.h>
#include <fstream>

using namespace std;

typedef struct measurement{
	int compar;
	int shift;
}Measurement;

void insertionSort(int tab[], int size, Measurement* m){
	int key;
	int j;
	
	for(int i=1;i<size;i++){
		key = tab[i];
		j  = i-1;
		while(j>=0 && tab[j]>key){
			cerr << "porownanie " << tab[j] << " z " << key << endl;
			m->compar++;
			cerr << "przestawienie " << tab[j+1] << " z " << tab[j] << endl;
			m->shift++;
			tab[j+1] = tab[j];
			j = j-1;
		}
		cerr << "przestawienie " << tab[j+1] << " z " << key << endl;
		m->shift++;
		tab[j+1] = key;
	}
}

int partition(int tab[],int start,int end,int p,Measurement* m){
	int i = start;
	int pivot = p;
	int z=0;
	for(int l=start;l<=end;l++){
		cerr << "porownanie " << tab[l] << " z " << p << endl;
		m->compar++;
		if(tab[l]==p){
			z = l;
			break;
		}
	}
	cerr << "przestawienie " << tab[start] << " z " << tab[z] << endl;
	m->shift++;
	swap(tab[start],tab[z]);
	for(int j=start+1;j<=end;j++){
		cerr << "porownanie " << tab[j] << " z " << pivot << endl;
		m->compar++;
		if(tab[j]<=pivot){
			i++;
			cerr << "przestawienie " << tab[i] << " z " << tab[j] << endl;
			m->shift++;
			swap(tab[i],tab[j]);
		}
	}
	cerr << "przestawienie " << tab[start] << " z " << tab[i] << endl;
	m->shift++;
	swap(tab[i],tab[start]);
	return i;
}

int median(int tab[],int start,int end,Measurement* me){
	int m,s=start;
	int t[end-start+1];
	
	for(int i=0;i<end-start+1;i++){
		t[i] = tab[s];
		s++;
	}
	insertionSort(t,end-start+1,me);
	m = t[((int)(end-start)/2)];
	
	return m;
}

int select(int tab[],int start,int end,int k,Measurement* m){
	int n,x,y;
	
	if((end-start+1)%5 == 0){
		n = (int)((end-start+1)/5);
	}
	else{
		n = ((int)((end-start+1)/5))+1;//liczba podzialow na 5el tablice
	}
	int mtab[n];
	int s = start;
	cerr << "porownanie " << start << " z " << end << endl;
	m->compar++;
	if(start>=end){
		return tab[start];
	}
	else{
		for(int i=0;i<n;i++){
			if(i+1==n){
				mtab[i] = median(tab,s,end,m);
			}
			else{
				mtab[i] = median(tab,s,s+4,m);
			}
			s = s+5;
		}
		
		x = select(mtab,0,n-1,(int)((n+1)/2),m);
	
		y = partition(tab,start,end,x,m);
	}
	cerr << "porownanie " << k << " z " << y << endl;
	m->compar++;
	if(k==y){
		return x;
	}
	if(k<y){
		return select(tab,start,y-1,k,m);
	}
	else{
		return select(tab,y+1,end,k,m);
	}
}

int randomPartition(int tab[],int start,int end,Measurement* m){
	srand(time(NULL));
	int i = start;
	int r = (rand()%((end-start)+1))+start;
	int pivot = tab[r];
	cerr << "pivot = " << pivot << endl;
	swap(tab[start],tab[r]);
	cerr << "przestawienie " << tab[start] << " z " << tab[r] << endl;
	m->shift++;
	for(int j=start+1;j<=end;j++){
		cerr << "porownanie " << tab[j] << " z " << pivot << endl;
		m->compar++;
		if(tab[j]<=pivot){
			i++;
			swap(tab[i],tab[j]);
			cerr << "przestawienie " << tab[i] << " z " << tab[j] << endl;
			m->shift++;
		}
	}
	swap(tab[i],tab[start]);
	cerr << "przestawienie " << tab[i] << " z " << tab[start] << endl;
	m->shift++;
	return i;
}

int randomSelect(int tab[],int start,int end,int k,Measurement* m){
	int r,z;
	cerr << "Tablica: ";
	for(int h=start;h<=end;h++){
		cerr << tab[h] << " ";
	}
	cerr << endl;
	cerr << "k = " << k << endl;
	cerr << "porownanie " << start << " z " << end << endl;
	m->compar++;
	if(start==end){
		return tab[start];
	}
	r = randomPartition(tab,start,end,m);
	z = r-start+1;
	cerr << "porownanie " << k << " z " << z << endl;
	m->compar++;
	if(k==z){
		return tab[r];
	}
	else if(k<z){
		return randomSelect(tab,start,r-1,k,m);
	}
	else{
		return randomSelect(tab,r+1,end,k-z,m);
	}
}

int main(int argc, char *argv[]){
	srand(time(NULL));
	int c=0;
	Measurement* m = new measurement;
	if(argc!=2){
		cout << "Zla liczba argumentow " << argc << endl;
	}
	else if(argc==2){
		int n,k,key,p;
		
		if(strcmp(argv[1],"-r") && strcmp(argv[1],"-p")){
			cout << "Zly argument" << endl;
		}
		
		cout << "Podaj wielkosc tablicy: ";
		cin >> n;
		cout << "Podaj pozycje: ";
		cin >> k;
		int tab[n],ctab[n];
		
		if(!strcmp(argv[1],"-r")){
			for(int i=0;i<n;i++){
				tab[i] = rand();
			}
		}
		else if(!strcmp(argv[1],"-p")){
			for(int i=0;i<n;i++){
				tab[i] = i+1;
			}
			for(int j=0;j<n;j++){
				p = rand()%n;
				swap(tab[j],tab[p]);
			}
		}
		for(int i=0;i<n;i++){
			ctab[i] = tab[i];
		}
		m->shift=0;
		m->compar=0;
		cerr << "Random Select" << endl;
		key = randomSelect(tab,0,n-1,k,m);
		cerr << "porownania: " << m->compar << endl;
		cerr << "przestawienia: " << m->shift << endl;
		for(int i=0;i<n;i++){
			if(ctab[i]==key && c==0){
				cout << "[" << ctab[i] << "] ";
				c = 1;
			}
			else{
				cout << ctab[i] << " ";
			}
		}
		cerr << endl;
		
		for(int i=0;i<n;i++){
			tab[i] = ctab[i];
		}
		
		m->shift=0;
		m->compar=0;
		c=0;
		cerr << "Select" << endl;
		key = select(tab,0,n-1,k-1,m);
		cerr << "porownania: " << m->compar << endl;
		cerr << "przestawienia: " << m->shift << endl;
		for(int i=0;i<n;i++){
			if(ctab[i]==key && c==0){
				cout << "[" << ctab[i] << "] ";
				c = 1;
			}
			else{
				cout << ctab[i] << " ";
			}
		}
	}
	return 0;
}