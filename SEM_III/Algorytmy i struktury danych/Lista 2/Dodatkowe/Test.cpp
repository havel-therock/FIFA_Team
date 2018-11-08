#include <iostream>
#include <cstdio>
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <string.h>
#include <fstream>
#include "IntType.hpp"
using namespace std;

struct measurement{
	int compar;
	int shift;
}Measurement;

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