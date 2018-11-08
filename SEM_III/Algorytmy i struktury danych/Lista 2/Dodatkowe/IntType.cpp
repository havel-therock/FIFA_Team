#include <cstdio>
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <string.h>
#include <fstream>

using namespace std;

struct measurement{
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