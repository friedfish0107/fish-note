#include<iostream>
#include<queue>

using namespace std;

const int MAXM=2e3+5;

int n,m;
long long a[MAXM][MAXM];
bool vis[MAXM][MAXM];
int x,y;

long long gcd(long long a,long long b){
	if(b==0)return a;
	return gcd(b,a%b);
}

struct node{
	int x,y,date;
};

int main(){
	cin>>n>>m;
	for(int i=1;i<=n;i++){
		for(int j=1;j<=m;j++){
			cin>>a[i][j];
		}
	}
	cin>>x>>y;
	queue<node>q;
	long long g=a[x][y];
	q.push(node{x,y,0});
	while(!q.empty()){
		node p=q.front();
		q.pop();
		if(p.x<1||p.x>n||p.y<1||p.y>m)continue;
		if (vis[p.x][p.y])continue;
		g=gcd(g,a[p.x][p.y]);
		if(g==1){
			cout<<p.date;
			return 0;
		}
		vis[p.x][p.y]=1;
		const int d[4][2]={{0,1},{0,-1},{1,0},{-1,0}};
		for(int i=0;i<4;i++){
			q.push(node{p.x+d[i][0],p.y+d[i][1],p.date+1});
		}
	}
	cout<<-1;
	return 0;
}
