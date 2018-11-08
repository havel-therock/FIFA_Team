#include <cstdio>
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <string.h>
#include <fstream>

using namespace std;

typedef struct measurement{
	int compar;
}Measurement;

int binary_search(int tab[],int start,int end,int x,Measurement* m){
	int s=0;
	if(end>=start){
		int mid = start+(end-start)/2;
		m->compar++;
		if(tab[mid]==x){
			s = 1;
			return s;
		}
		else if(tab[mid]>x){
			return binary_search(tab,start,mid-1,x,m);
		}
		else{
			return binary_search(tab,mid+1,end,x,m);
		}
	}
	return s;
}

int main(int argc, char *argv[]){
	int n,x,b;
	Measurement* m = new measurement;
	clock_t start_t, end_t, total_t;
	double ti;
	
	if(strcmp(argv[1],"-t")){
		m->compar = 0;
		cout << "Podaj wielkosc tablicy: ";
		cin >> n;
		int tab[n];
		cout << "Podaj wartosc do znalezienia: ";
		cin >> x;
		cout << "Podaj dane: ";
		for(int i=0;i<n;i++){
			cin >> tab[i];
		}
		b = binary_search(tab,0,n-1,x,m);
		cout << "wynik: " << b << endl;
	}
	else if(!strcmp(argv[1],"-t")){
		for(int i=1;i<=100;i++){
			n = i*1000;
			int tab[n];
			x = tab[0];
			m->compar = 0;
			for(int j=0;j<n;j++){
				tab[j] = j*2;
			}
			start_t = clock();
			b = binary_search(tab,0,n-1,x,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			cerr << n << "		porownania:	" << m->compar;
			cerr << "		czas:	" << ti << "s" << endl;
		}
	}
	return 0;
}