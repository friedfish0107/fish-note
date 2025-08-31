#include<fstream>
#include<iostream>
#include<cstdio>
using namespace std;

struct Animal{
    int A,B,C,depth;
	Animal* N;
    
};

int main(){
    int lis[100]={};
    int n=5;
    int j=1;
    for(int i=0;i<n;i++){
        int* p=lis+i;
        if(i<2){
            j=1;
        }
        else{
            j=*(p-1)+*(p-2);
        }
        *(lis+i)=j;
    }
    cout<<lis[4];
    return 0;
}

