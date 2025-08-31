#include <iostream>
#include <cmath>
using namespace std;

int f(int m,int n,int maxm){
	if(n==1)return m;
	//if(m==0)return 0;
	int ans=0;
	cout<<endl<<m<<" "<<n<<" "<<maxm<<" "<<endl;
	for(int i=maxm;i>0;i--){
		cout<<i<<" ";
		ans+=f(m-i,n-1,min(i,m-i))+i;
		cout
	}
	//cout<<endl;
	return ans;
}

int main(){
	//cout<<f(5,5,5);
	for(int i=5;i>0;i--){
		cout<<i<<" ";
		cout<<f(5-i,5-1,min(i,5-i));
		cout<<endl;
	}
	return 0;
}
