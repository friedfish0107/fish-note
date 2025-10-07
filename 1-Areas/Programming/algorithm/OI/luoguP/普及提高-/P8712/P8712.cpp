#include <bits/stdc++.h>
using namespace std;
const int MAXN=1e5+10;

int f[MAXN][15];

int main(){
	int n,k;
	int a[MAXN],t[10];
	cin>>n>>k;
	for(int i=0;i<n;i++){
		cin>>a[i];
		f[a[i]%k][0]++;
		int x=10;
		for(int i=1;i<=10;i++){
			f[][i]=x%k;
			//cout<<t[i]<<" ";
			x*=10;
		}
	}
	

	long long ans=0;
	for(int i=0;i<n;i++){
		int _=a[i],a_=-1,b;
		while(_>0){
			a_++;
			_/=10;
			//cout<<1;
		}
		b=a[i]%k;
		ans+=
		if(((long long)a_*a[i]-b)%k==0)ans--;
		//cout<<3;
	}
	cout<<ans;
}
