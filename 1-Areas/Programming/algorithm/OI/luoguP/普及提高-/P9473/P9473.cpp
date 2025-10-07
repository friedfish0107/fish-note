#include<iostream>
#include<algorithm>
#include<stdio.h>
#include<cstring>
using namespace std;

const int MAXN=5e5+10;
const int MAXA=1e8+10;
const int QRTA=1e4+5;
int p[QRTA];
int g[QRTA];
int l[QRTA];
int n[QRTA];
set<int>seen;
int cntp=0;

void ash(){
	p[0]=2;
	for(int i=3;i<QRTA;i++){
		bool f=0;
		for(int j=0;j<=cntp;j++){
			if(i%p[j]==0){
				f=1;
				break;
			}
		}
		if(f==0){
			p[++cntp]=i;
			//cout<<i<<" ";
		}
	}
}
void reset(){
	memset(n,0,sizeof n);
	memset(l,0,sizeof l);
	memset(g,0x3f,sizeof g);
}
void f(int x){
	for(int i=0;i<QRTA;i++){
		if(p[i]==0)break;
		int tempx=x;
		int temp=0;
		while(tempx%p[i]==0){
			tempx/=p[i];
			temp++;
		}
		n[i]+=temp;
		l[i]=max(l[i],temp);
		g[i]=min(g[i],temp);
	}
	return;
}
void cmp(){
	for(int i=0;i<QRTA;i++){
		if(p[i]==0)break;
		//printf("%d %d %d %d\n",p[i],g[i],l[i],n[i]);
		if(n[i]!=l[i]+g[i]){
			cout<<"No\n";
			return;
		}
	}
	cout<<"Yes\n";
	return;
}
int T;
int main(){
	ash();
	cin>>T;
	while(T--){
		reset();
		int m;
		cin>>m;
		while(m--){
			int x;
			cin>>x;
			f(x);
		}
		cmp();
	}
	return 0;
}

