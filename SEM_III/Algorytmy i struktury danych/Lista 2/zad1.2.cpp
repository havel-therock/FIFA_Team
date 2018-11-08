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

void countSort(int tab[], int size, int k, int way, Measurement* m){
	int stab[size];
	int count[10] = {0};
	
	for(int i=0;i<size;i++){
		count[(tab[i]/k)%10]++;
	}
	for(int i=1;i<=10;i++){
		count[i] += count[i-1];
	}
	for(int i=size-1;i>=0;i--){
		stab[(count[(tab[i]/k)%10])-1] = tab[i];
		count[(tab[i]/k)%10]--;
	}
	for(int i=0;i<size;i++){
		tab[i] = stab[i];
	}
}

void radixSort(int tab[], int size, int way, Measurement* m){
	int k;
	int max=tab[0];
	
	//get max
	for(int i=1;i<size;i++){
		m->compar++;
		cerr << "porownanie" << endl;
		if(tab[i]>max){
			max = tab[i];
		}
	}
	
	for(k=1;max/k>0;k*=10){
		countSort(tab,size,k,way,m);
	}
}

void insertionSort(int tab[], int size, int way, Measurement* m){
	int key;
	//increase
	if(way==1){
		for(int i=1;i<size;i++){
			key = tab[i];
			for(int j=i;j>0;j--){
				m->compar++;
				cerr << "" << endl;
				if(tab[j-1]>=key){
					tab[j] = tab[j-1];
					tab[j-1] = key;
					m->shift++;
					cerr << "" << endl;
				}
			}
		}
	}
	//decrease
	else if(way==0){
		for(int i=1;i<size;i++){
			key = tab[i];
			for(int j=i;j>0;j--){
				m->compar++;
				cerr << "" << endl;
				if(tab[j-1]<=key){
					tab[j] = tab[j-1];
					tab[j-1] = key;
					m->shift++;
					cerr << "" << endl;
				}
			}
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
			cerr << "" << endl;
			if (tab[j] < tab[i]){
				t[k] = tab[j];
				m->shift++;
				cerr << "" << endl;
				j++;
			}
			else{
				t[k] = tab[i];
				m->shift++;
				cerr << "" << endl;
				i++;
			}
			k++;
		}
	}
	//decrease
	else if(way==0){
		while (i <= middle && j <= end){
			m->compar++;
			cerr << "" << endl;
			if (tab[j] > tab[i]){
				t[k] = tab[j];
				m->shift++;
				cerr << "" << endl;
				j++;
			}
			else{
				t[k] = tab[i];
				m->shift++;
				cerr << "" << endl;
				i++;
			}
			k++;
		}
	}
	while (i <= middle){
		t[k] = tab[i];
		m->shift++;
		cerr << "" << endl;
		i++;
		k++;
	}
	while (j <= end){
		t[k] = tab[j];
		m->shift++;
		cerr << "" << endl;
		j++;
		k++;
	}
	for (i = 0; i <= end-start; i++){
		tab[start+i] = t[i]; 
		m->shift++;
		cerr << "" << endl;
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
				cerr << "" << endl;
				i++;
			}
			while (tab[j] > pivot){
				m->compar++;
				cerr << "" << endl;
				j--;
			}
			if (i <= j) {
				swap(tab[i],tab[j]);
				m->shift++;
				cerr << "" << endl;
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
				cerr << "" << endl;
				i++;
			}
			while (tab[j] < pivot){
				m->compar++;
				cerr << "" << endl;
				j--;
			}
			if (i <= j) {
				swap(tab[i],tab[j]);
				m->shift++;
				cerr << "" << endl;
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
			if(tab[i] >= tab[i+1]){
				cout << "Wykryto blad" << endl;
			}
		}
	}
	else if(way==0){
		for(int i=0;i<n-1;i++){
			if(tab[i] <= tab[i+1]){
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
			cerr << "" << endl;
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
					cerr << "" << endl;
					if(tab[j]<p){
						swap(tab[i],tab[j]);
						m->shift++;
						cerr << "" << endl;
						i++;
						j++;
						d++;
					}
					else{
						m->compar++;
						cerr << "" << endl;
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
					cerr << "" << endl;
					if(tab[k]>q){
						k--;
						d--;
					}
					else{
						m->compar++;
						cerr << "" << endl;
						if(tab[k]<p){
							t = tab[k];
							tab[k] = tab[j];
							m->shift++;
							cerr << "" << endl;
							tab[j] = tab[i];
							m->shift++;
							cerr << "" << endl;
							tab[i] = t;
							m->shift++;
							cerr << "" << endl;
							i++;
							d++;
						}
						else{
							swap(tab[j],tab[k]);
							m->shift++;
							cerr << "" << endl;
						}
						j++;
					}
				}
				cout << "While" << endl;
				for(int i=0;i<end+1;i++){
				cout << i+1 << ":\t" << tab[i] << endl;
				}
			}
			tab[start] = tab[i-1];
			m->shift++;
			cerr << "" << endl;
			tab[i-1] = p;
			m->shift++;
			cerr << "" << endl;
			tab[end] = tab[k+1];
			m->shift++;
			cerr << "" << endl;
			tab[k+1] = q;
			m->shift++;
			cerr << "" << endl;
			for(int i=0;i<end+1;i++){
				cout << i+1 << ":\t" << tab[i] << endl;
			}
			dpQuickSort(tab,start,i-2,way,m);
			dpQuickSort(tab,i,k,way,m);
			dpQuickSort(tab,k+2,end,way,m);
		}
	}
	else if(way==0){
		if(start<=end){
			m->compar++;
			cerr << "" << endl;
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
					cerr << "" << endl;
					if(tab[j]>p){
						swap(tab[i],tab[j]);
						m->shift++;
						cerr << "" << endl;
						i++;
						j++;
						d++;
					}
					else{
						m->compar++;
						cerr << "" << endl;
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
					cerr << "" << endl;
					if(tab[k]<q){
						k--;
						d--;
					}
					else{
						m->compar++;
						cerr << "" << endl;
						if(tab[k]>p){
							t = tab[k];
							tab[k] = tab[j];
							m->shift++;
							cerr << "" << endl;
							tab[j] = tab[i];
							m->shift++;
							cerr << "" << endl;
							tab[i] = t;
							m->shift++;
							cerr << "" << endl;
							i++;
							d++;
						}
						else{
							swap(tab[j],tab[k]);
							m->shift++;
							cerr << "" << endl;
						}
						j++;
					}
				}
			}
			tab[start] = tab[i-1];
			m->shift++;
			cerr << "" << endl;
			tab[i-1] = p;
			m->shift++;
			cerr << "" << endl;
			tab[end] = tab[k+1];
			m->shift++;
			cerr << "" << endl;
			tab[k+1] = q;
			m->shift++;
			cerr << "" << endl;
			dpQuickSort(tab,start,i-2,way,m);
			dpQuickSort(tab,i,k,way,m);
			dpQuickSort(tab,k+2,end,way,m);
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

		for(int i=0;i<n;i++){
			tab[i] = rand();
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
			insertionSort(tab,n,way,m);
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
		
		plik << "Tablica	InsertionSort-Porownania	InsertionSort-Przestawienia	InsertionSort-Czas	InsertionSort-c/n	InsertionSort-s/n	MergeSort-Porownania	MergeSort-Przestawienia	MergeSort-Czas	MergeSort-c/n	MergeSort-s/n	QuickSort-Porownania	QuickSort-Przestawienia	QuickSort-Czas	QuickSort-c/n	QuickSort-s/n	Dual-pivotQuickSort-Porownania	Dual-pivotQuickSort-Przestawienia	Dual-pivotQuickSort-Czas	Dual-pivotQuickSort-c/n	Dual-pivotQuickSort-s/n	RadixSort-Porownania	RadixSort-Przestawienia	RadixSort-Czas	RadixSort-c/n	RadixSort-s/n" << endl;
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
			m->compar = 0;
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
			}
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
			//radix
			m->compar = 0;
			m->shift = 0;
			start_t = clock();
			radixSort(copy,n,way,m);
			end_t = clock();
			total_t = end_t - start_t;
			ti = (double)total_t/CLOCKS_PER_SEC;
			plik << "	" << m->compar;
			plik << "	" << m->shift;
			plik << "	" << ti;
			plik << "	" << m->compar/n;
			plik << "	" << m->shift/n;
			
			plik << endl;
		}
	}
	return 0;
}