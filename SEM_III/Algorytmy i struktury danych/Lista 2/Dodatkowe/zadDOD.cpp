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

void insertionSort(int tab[], int start,int end, int way, Measurement* m){
	int key;
	int j;
	//increase
	if(way==1){
		for(int i=start+1;i<=end;i++){
			key = tab[i];
			j  = i-1;
			while(j>=0 && tab[j]>key){
				m->shift++;
				cerr << "";
				tab[j+1] = tab[j];
				j = j-1;
				m->compar++;
				cerr << "";
			}
			tab[j+1] = key;
			m->shift++;
			cerr << "";
		}
	}
	//decrease
	else if(way==0){
		for(int i=start+1;i<=end;i++){
			key = tab[i];
			j  = i-1;
			m->compar++;
			cerr << "";
			while(j>=0 && tab[j]<key){
				m->shift++;
				cerr << "";
				tab[j+1] = tab[j];
				j = j-1;
				m->compar++;
				cerr << "";
			}
			tab[j+1] = key;
			m->shift++;
			cerr << "";
		}
	}
}

void merge(int tab[], int start, int middle, int end, int way, Measurement* m){
	int *t = new int[(end-start+1)];
	int i = start, j = middle+1, k = 0;
	
	//increase
	if(way==1){
		while (i <= middle && j <= end){
			m->compar++;
			cerr << "";
			if (tab[j] < tab[i]){
				t[k] = tab[j];
				m->shift++;
				cerr << "";
				j++;
			}
			else{
				t[k] = tab[i];
				m->shift++;
				cerr << "";
				i++;
			}
			k++;
		}
	}
	//decrease
	else if(way==0){
		while (i <= middle && j <= end){
			m->compar++;
			cerr << "";
			if (tab[j] > tab[i]){
				t[k] = tab[j];
				m->shift++;
				cerr << "";
				j++;
			}
			else{
				t[k] = tab[i];
				m->shift++;
				cerr << "";
				i++;
			}
			k++;
		}
	}
	while (i <= middle){
		t[k] = tab[i];
		m->shift++;
		cerr << "";
		i++;
		k++;
	}
	while (j <= end){
		t[k] = tab[j];
		m->shift++;
		cerr << "";
		j++;
		k++;
	}
	for (i = 0; i <= end-start; i++){
		tab[start+i] = t[i]; 
	}
}
 
void mergeSort(int tab[], int start, int end, int way, Measurement* m){
	if (start < end){
		mergeSort(tab,start,(int)(start + end)/2,way,m);
		mergeSort(tab,(int)(((start+end)/2))+1,end,way,m);
		merge(tab,start,(int)((start+end)/2),end,way,m);
	}
}

void quickSort(int tab[],int start, int end, int way, Measurement* m){
	int i = start, j = end, pivot = tab[(start+end)/2];
	//increase
	if(way==1){
		//partition
		while (i <= j) {
			while (tab[i] < pivot){
				m->compar++;
				cerr << "";
				i++;
			}
			while (tab[j] > pivot){
				m->compar++;
				cerr << "";
				j--;
			}
			if (i <= j) {
				swap(tab[i],tab[j]);
				m->shift++;
				cerr << "";
				i++;
				j--;
			}
		}
		//recursion
		if (start < j){
			quickSort(tab,start,j,way,m);
		}
		if (i < end){
			quickSort(tab,i,end,way,m);
		}
	}
	//decrease
	else if(way==0){
		//partition
		while (i <= j) {
			while (tab[i] > pivot){
				m->compar++;
				cerr << "";
				i++;
			}
			while (tab[j] < pivot){
				m->compar++;
				cerr << "";
				j--;
			}
			if (i <= j) {
				swap(tab[i],tab[j]);
				m->shift++;
				cerr << "";
				i++;
				j--;
			}
		}
		//recursion
		if (start < j){
			quickSort(tab,start,j,way,m);
		}
		if (i < end){
			quickSort(tab,i,end,way,m);
		}
	}
}

void check(int way, int tab[],int n){
	if(way==1){
		for(int i=0;i<n-1;i++){
			if(tab[i] > tab[i+1]){
				cout << "Wykryto blad" << endl;
			}
		}
	}
	else if(way==0){
		for(int i=0;i<n-1;i++){
			if(tab[i] < tab[i+1]){
				cout << "Wykryto blad" << endl;
			}
		}
	}
}

void dpQuickSort(int tab[],int start, int end, int way, Measurement* m){
	int p, q, i, k, j, d, t;
	
	//increase
	if(way==1){
		if(start<=end){
			m->compar++;
			cerr << "";
			if(tab[end]<tab[start]){
				p = tab[end];
				q = tab[start];
			}
			else{
				p = tab[start];
				q = tab[end];
			}
			i = start+1;
			k = end-1;
			j = i;
			d = 0;
			while(j<=k){
				if(d>=0){
					m->compar++;
					cerr << "";
					if(tab[j]<p){
						swap(tab[i],tab[j]);
						m->shift++;
						cerr << "";
						i++;
						j++;
						d++;
					}
					else{
						m->compar++;
						cerr << "";
						if(tab[j]<q){
							j++;
						}
						else{
							swap(tab[j],tab[k]);
							k--;
							d--;
						}
					}
				}
				else{
					m->compar++;
					cerr << "";
					if(tab[k]>q){
						k--;
						d--;
					}
					else{
						m->compar++;
						cerr << "";
						if(tab[k]<p){
							t = tab[k];
							tab[k] = tab[j];
							m->shift++;
							cerr << "";
							tab[j] = tab[i];
							m->shift++;
							cerr << "";
							tab[i] = t;
							m->shift++;
							cerr << "";
							i++;
							d++;
						}
						else{
							swap(tab[j],tab[k]);
							m->shift++;
							cerr << "";
						}
						j++;
					}
				}
			}
			tab[start] = tab[i-1];
			m->shift++;
			cerr << "";
			tab[i-1] = p;
			m->shift++;
			cerr << "";
			tab[end] = tab[k+1];
			m->shift++;
			cerr << "";
			tab[k+1] = q;
			m->shift++;
			cerr << "";
			dpQuickSort(tab,start,i-2,way,m);
			dpQuickSort(tab,i,k,way,m);
			dpQuickSort(tab,k+2,end,way,m);
		}
	}
	else if(way==0){
		if(start<=end){
			m->compar++;
			cerr << "";
			if(tab[end]>tab[start]){
				p = tab[end];
				q = tab[start];
			}
			else{
				p = tab[start];
				q = tab[end];
			}
			i = start+1;
			k = end-1;
			j = i;
			d = 0;
			while(j<=k){
				if(d>=0){
					m->compar++;
					cerr << "";
					if(tab[j]>p){
						swap(tab[i],tab[j]);
						m->shift++;
						cerr << "";
						i++;
						j++;
						d++;
					}
					else{
						m->compar++;
						cerr << "";
						if(tab[j]>q){
							j++;
						}
						else{
							swap(tab[j],tab[k]);
							k--;
							d--;
						}
					}
				}
				else{
					m->compar++;
					cerr << "";
					if(tab[k]<q){
						k--;
						d--;
					}
					else{
						m->compar++;
						cerr << "";
						if(tab[k]>p){
							t = tab[k];
							tab[k] = tab[j];
							m->shift++;
							cerr << "";
							tab[j] = tab[i];
							m->shift++;
							cerr << "";
							tab[i] = t;
							m->shift++;
							cerr << "";
							i++;
							d++;
						}
						else{
							swap(tab[j],tab[k]);
							m->shift++;
							cerr << "";
						}
						j++;
					}
				}
			}
			tab[start] = tab[i-1];
			m->shift++;
			cerr << "";
			tab[i-1] = p;
			m->shift++;
			cerr << "";
			tab[end] = tab[k+1];
			m->shift++;
			cerr << "";
			tab[k+1] = q;
			m->shift++;
			cerr << "";
			dpQuickSort(tab,start,i-2,way,m);
			dpQuickSort(tab,i,k,way,m);
			dpQuickSort(tab,k+2,end,way,m);
		}
	}
}

void hybrid(int tab[], int start, int end, int way, Measurement* m){
	int i = start, j = end, pivot = tab[(start+end)/2];
	//increase
	if(way==1){
		//partition
		while (i <= j) {
			while (tab[i] < pivot){
				m->compar++;
				cerr << "";
				i++;
			}
			while (tab[j] > pivot){
				m->compar++;
				cerr << "";
				j--;
			}
			if (i <= j) {
				swap(tab[i],tab[j]);
				m->shift++;
				cerr << "";
				i++;
				j--;
			}
		}
		//recursion
		if (start < j){
			if(j-start+1>10){
				quickSort(tab,start,j,way,m);
			}
			else{
				insertionSort(tab,start,j,way,m);
			}
		}
		if (i < end){
			if(end-i+1>10){
				quickSort(tab,i,end,way,m);
			}
			else{
				insertionSort(tab,i,end,way,m);
			}
		}
	}
	//decrease
	else if(way==0){
		//partition
		while (i <= j) {
			while (tab[i] > pivot){
				m->compar++;
				cerr << "";
				i++;
			}
			while (tab[j] < pivot){
				m->compar++;
				cerr << "";
				j--;
			}
			if (i <= j) {
				swap(tab[i],tab[j]);
				m->shift++;
				cerr << "";
				i++;
				j--;
			}
		}
		//recursion
		if (start < j){
			if(j-start+1>10){
				quickSort(tab,start,j,way,m);
			}
			else{
				insertionSort(tab,start,j,way,m);
			}
		}
		if (i < end){
			if(end-i+1>10){
				quickSort(tab,i,end,way,m);
			}
			else{
				insertionSort(tab,i,end,way,m);
			}
		}
	}
}

int main(int argc, char *argv[]){
	if(argc!=5 && argc!=3){
		cout << "Zla liczba argumentow " << argc << endl;
	}
	else if(argc==5){	
		int n;
		int way; //0 if decrese; 1 else
		srand(time(NULL));
		Measurement* m = new measurement;
		m->compar = 0;
		m->shift = 0;
		clock_t start_t, end_t, total_t;
		double ti;

		cout << "Podaj wielkosc tablicy: ";
		cin >> n;
		int tab[n];
		cout << "Podaj dane" << endl;

		for(int i=0;i<n;i++){
			cin >> tab[i];
		}
		cout << "Do posortowania" << endl;
		for(int i=0;i<n;i++){
			cout << i+1 << ":\t" << tab[i] << endl;
		}

		if(!strcmp(argv[4],"<=")){
			way = 1;
		}
		else if(!strcmp(argv[4],">=")){
			way = 0;
		}

		if(!strcmp(argv[2],"insert")){
			start_t = clock();
			insertionSort(tab,0,n-1,way,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			check(way,tab,n);

			cout << "Wynik sortowania" << endl;
			for(int i=0;i<n;i++){
				cout << i+1 << ":\t" << tab[i] << endl;
			}
			cout << "Posortowano " << n << " elementow" << endl;
			cerr << "Insertion Sort:" << endl;
			cerr << "porownania: " << m->compar << endl;
			cerr << "przestawienia: " << m->shift << endl;
			cerr << "czas: " << ti << "s" << endl;
		}
		else if(!strcmp(argv[2],"merge")){
			start_t = clock();
			mergeSort(tab,0,n-1,way,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			check(way,tab,n);	

			cout << "Wynik sortowania" << endl;
			for(int i=0;i<n;i++){
				cout << i+1 << ":\t" << tab[i] << endl;
			}
			cout << "Posortowano " << n << " elementow" << endl;
			cerr << "Merge Sort:" << endl;
			cerr << "porownania " << m->compar << endl;
			cerr << "przestawienia " << m->shift << endl;
			cerr << "czas: " << ti << "s" << endl;
		}
		else if(!strcmp(argv[2],"quick")){
			start_t = clock();
			quickSort(tab,0,n-1,way,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			check(way,tab,n);
			
			cout << "Wynik sortowania" << endl;
			for(int i=0;i<n;i++){
				cout << i+1 << ":\t" << tab[i] << endl;
			}
			cout << "Posortowano " << n << " elementow" << endl;
			cerr << "Quick Sort:" << endl;
			cerr << "porownania " << m->compar << endl;
			cerr << "przestawienia " << m->shift << endl;
			cerr << "czas: " << ti << "s" << endl;
		}
		else if(!strcmp(argv[2],"dualpivot")){
			start_t = clock();
			dpQuickSort(tab,0,n-1,way,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			check(way,tab,n);
			
			cout << "Wynik sortowania" << endl;
			for(int i=0;i<n;i++){
				cout << i+1 << ":\t" << tab[i] << endl;
			}
			cout << "Posortowano " << n << " elementow" << endl;
			cerr << "Dual-pivot Quick Sort:" << endl;
			cerr << "porownania " << m->compar << endl;
			cerr << "przestawienia " << m->shift << endl;
			cerr << "czas: " << ti << "s" << endl;
		}
		else{
			cout << "Podano niewlasciwy typ sortowania, wpisz:" << endl << "insert - Insertion Sort" << endl << "merge - Merge Sort" << endl << "quick - Quick Sort" << endl << "dualpivot - Dula-pivot Quick Sort" << endl;
		}
	}
	else if(argc==3){
		int n;
		int way=1; //0 if decrese; 1 else
		srand(time(NULL));
		Measurement* m = new measurement;
		m->compar = 0;
		m->shift = 0;
		clock_t start_t, end_t, total_t;
		double ti;
		ofstream plik(argv[2]);
		
		plik << "Tablica	MergeSort-Porownania	MergeSort-Przestawienia	MergeSort-Czas	MergeSort-c/n	MergeSort-s/n	QuickSort-Porownania	QuickSort-Przestawienia	QuickSort-Czas	QuickSort-c/n	QuickSort-s/n	Dual-pivotQuickSort-Porownania	Dual-pivotQuickSort-Przestawienia	Dual-pivotQuickSort-Czas	Dual-pivotQuickSort-c/n	Dual-pivotQuickSort-s/n	Hybrid-Porownania	Hybrid-Przestawienia	Hybrid-Czas	Hybrid-c/n	Hybrid-s/n" << endl;
		for(int i=1;i<=100;i++){
			n = i*100;
			int tab[n],copy[n];
			for(int i=0;i<n;i++){
				tab[i] = rand();
			}
			plik << n;//tablica
			
			for(int i=0;i<n;i++){
				copy[i] = tab[i];
			}
			//insert
			/*m->compar = 0;
			m->shift = 0;
			start_t = clock();
			insertionSort(copy,n,way,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			plik << "	" << m->compar;
			plik << "	" << m->shift;
			plik << "	" << ti;
			plik << "	" << m->compar/n;
			plik << "	" << m->shift/n;
			
			for(int i=0;i<n;i++){
				copy[i] = tab[i];
			}*/
			//merge
			m->compar = 0;
			m->shift = 0;
			start_t = clock();
			mergeSort(copy,0,n-1,way,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			//plik << "Merge Sort:" << endl;
			//plik << "Posortowano	" << n << endl;
			plik << "	" << m->compar;
			plik << "	" << m->shift;
			plik << "	" << ti;
			plik << "	" << m->compar/n;
			plik << "	" << m->shift/n;
			
			for(int i=0;i<n;i++){
				copy[i] = tab[i];
			}
			//quick
			m->compar = 0;
			m->shift = 0;
			start_t = clock();
			quickSort(copy,0,n-1,way,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			//plik << "Quick Sort:" << endl;
			//plik << "Posortowano	" << n << endl;
			plik << "	" << m->compar;
			plik << "	" << m->shift;
			plik << "	" << ti;
			plik << "	" << m->compar/n;
			plik << "	" << m->shift/n;
			
			for(int i=0;i<n;i++){
				copy[i] = tab[i];
			}
			//dualpivot
			m->compar = 0;
			m->shift = 0;
			start_t = clock();
			dpQuickSort(copy,0,n-1,way,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			//plik << "Dual-pivot Quick Sort:" << endl;
			//plik << "Posortowano	" << n << endl;
			plik << "	" << m->compar;
			plik << "	" << m->shift;
			plik << "	" << ti;
			plik << "	" << m->compar/n;
			plik << "	" << m->shift/n;
			
			for(int i=0;i<n;i++){
				copy[i] = tab[i];
			}
			
			//hybrid
			m->compar = 0;
			m->shift = 0;
			start_t = clock();
			hybrid(copy,0,n-1,way,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			//plik << "Dual-pivot Quick Sort:" << endl;
			//plik << "Posortowano	" << n << endl;
			plik << "	" << m->compar;
			plik << "	" << m->shift;
			plik << "	" << ti;
			plik << "	" << m->compar/n;
			plik << "	" << m->shift/n;
			
			for(int i=0;i<n;i++){
				copy[i] = tab[i];
			}
			
			plik << endl;
		}
	}
	return 0;
}