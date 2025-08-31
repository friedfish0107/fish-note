# include<iostream>
using namespace std;
const int N=1e6+10;
const int logN=30;
int log[N];
int f[N][logN];
void prelog(){
    log[1]=0;
    log[2]=1;
    for(int i=2;i<N;i++){
        log[i]=log[i/2]+1;
    }
}
int main(){
    int n,m;
    prelog();
    cin>>n>>m;
    for(int i=1;i<=n;i++){
        cin>>f[i][0];
    }
    for(int j=1;j<=logN;j++){
        for(int i=1;i+(1<<j)-1<=n;i++){
            f[i][j]=max(f[i][j-1],f[i+(1<<(j-1))][j-1]);
        }
    }
    int l=0,r=0,s=0;
    while(m--){
        cin>>l>>r;
        s=log[r-l+1];
        cout<<max(f[l][s],f[r-(1<<s)+1][s])<<'\n';
    }
    return 0;
}
