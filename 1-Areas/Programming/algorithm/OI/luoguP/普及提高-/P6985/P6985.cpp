#include<bits/stdc++.h>
using namespace std;

const int SIZE=1e6+10;
const int M=1e6-3;

struct hash_map()
{
	struct Data{
		long long key;
		int value;
		int next;
	}data[SIZE];
	
	int h[M],cnt;
	
	int hash(long long n)return (n%M+M)%M;
	
	int& operator[](long long n){
		int ha=hash(n);
		for(int p=h[ha];p;p=data[p].next){
			if(data[p].key==n)return data[p].value;
		}
		return data[++cnt]=Data({n,-1,h[ha]}),h[ha]=cnt,data[cnt].value;
	}
	
	int find(long long n){
		int ha=hash(n);
		for(int p=h[ha];p;p=data[p].next){
			if(data[p].key==n)return data[p].value;
		}
		return -1;
	}
	
	void init(){
		cnt=0;
		memset(h,0,sizeof(h));
	}
}A,vis;
long long hash21(int x,int y){
	return x<<31+y;
}
struct node(){
	int x2,y2;
	bool operator<(node a,node b){
		return a.x2+a.y2>b.x2+b.y2;
	}
	long long hash(){
		return x2<<31+y2;
	}
}R[1010];
int main(){
	int c;
	cin>>c;
	while(c--){
		A.init();
		vis.init();
		int r,cnt=0;
		cin>>r;
		int ans=0;
		for(int i=0;i<r;i++){
			int x1,y1,x2,y2;
			cin>>x1>>y1>>x2>>y2;
			R[i].x2=x2;
			R[i].y2=y2;
			for(int i=x1;i<=x2;i++){
				for(int j=y1,j<=y2,j++){
					A[hash21(i,j)]=1;
				}
			}
		}
		sort(R,R+r);
		for(int i=0,i<r;i++){
			if(vis.find(R[i].hash()))continue;
			queue<pair<int,int>>q;
			q.push({R[i].x2,R[i].y2});
			
			while(q.size()){
				pair<int,int>p=q.front();
				q.pop();
				if(vis.find(p))continue;
				
			}
		}
	}
}
