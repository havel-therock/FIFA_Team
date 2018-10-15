//@author Piotr Klepczyk

#include <string.h>
#include <stdio.h>
#include <iostream>
#include <conio.h>
#include <algorithm>
#include <cstring>

using namespace std;

int* TableBuild(string P){
	int m=P.size();
	int *pi = new int[m];
	pi[0]=0;
	pi[1]=0;
	int k=0;
	
	for(int j=2;j<=m;j++){
		while((k>0)&&(P[k]!=P[j-1])){
			k = pi[k];
		}
		if(P[k]==P[j-1]){
			k++;
		}
		pi[j]=k;
	}
	return pi;
}

void KMP(string P,string T){
	int i=1;
	int j=0;
	int n=T.size();
	int m=P.size();
	int *pi;
	pi = TableBuild(P);
	
	while(i<=n-m+1){
		j=pi[j];
		while((j<m)&&(P[j]==T[i+j-1])){
			j++;
		}
		if(j==m){
			cout<<"Wzorzec wystepuje od pozycji: "<<i<<"\n";
		}
		i=i+max(1,j-pi[j]);
	}
}

int main(void){
	string P;
	string T;
	cout<<"Podaj wzorzec:	";
	getline(cin,P);
	cout<<"Podaj tekst:	";
	getline(cin,T);
	KMP(P,T);
	return 0;
}