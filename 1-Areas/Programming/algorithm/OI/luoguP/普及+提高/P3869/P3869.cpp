#include <iostream>
#include <queue>
#include <fstream>
using namespace std;

int rs,cs;
int map[35][35];
bool dp[35][35][2100];
struct trap{
	int r,c,r2,c2;
}traps[15];


int sr,sc,tr,tc;

int k;

int main(){
	cin>>rs>>cs;
	for(int i=1;i<=rs;i++){
		for(int j=1;j<=cs;j++){
			char x;
			cin>>x;
			if(x=='S'){
				sr=i;sc=j;
			}
			if(x=='T'){
				tr=i;tc=j;
			}
			if(x=='#')map[i][j]=1;
			else map[i][j]=0;
		}
	}
	cin>>k;
	for(int i=0;i<k;i++){
		cin>>traps[i].r>>traps[i].c>>traps[i].r2>>traps[i].c2;
	}
	queue<int>qur;
	queue<int>quc;
	queue<int>qus;
	queue<int>qut;
	qur.push(sr);
	quc.push(sc);
	qus.push(0);
	qut.push(0);
	dp[sr][sc][0]=true;
	int d[4][2]={{0,1},{0,-1},{1,0},{-1,0}};
	
	int r,c,s,t;
	while (qur.size()){
		r=qur.front();
		c=quc.front();
		s=qus.front();
		t=qut.front();
		qur.pop();
		quc.pop();
		qus.pop();
		qut.pop();
		if(r==tr&&c==tc){
			cout<<s;
			break;
		}
		for(int i=0;i<k;i++){
			if(r==traps[i].r&&c==traps[i].c){
				t^=(1<<i);
			}
			if(t>>i&1){
				map[traps[i].r2][traps[i].c2]^=1;
			}
		}
		for(int i=0;i<4;i++){
			int rp=r+d[i][0];
			int cp=c+d[i][1];
			
			if(rp<=0||cp<=0||rp>rs||cp>cs)continue;
			if(!map[rp][cp]&&dp[rp][cp][t]==false){
				dp[rp][cp][t]=true;
				qur.push(rp);
				quc.push(cp);
				qus.push(s+1);
				qut.push(t);
			}
		}
		for(int i=0;i<k;i++){
			if(t>>i&1)map[traps[i].r2][traps[i].c2]^=1;
		}
		//cout<<r<<" "<<c<<" "<<s<<" "<<t<<endl;
	}
	return 0;
}
