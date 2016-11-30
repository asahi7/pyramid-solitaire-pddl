#include <iostream>
#include <string>

using namespace std;

int main(){
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);
    string str;
    string a[100], b[100];
    bool init = true;
    int l = 1, r = 1, cur = 1, tot = 0;
    while(tot < 28 && cin >> str){
        if(str != "__"){
            //cout << "        (pyramid " + str << ")" << endl;
        //    cout << str << " ";
        }
        tot++;
        if(init == true){
            b[1] = str;
            cur = 0;
            l = 1;
            r = 2;
            init = false;
            continue;
        }
        cur++;
        a[cur] = str;
        if(str != "__"){
            if(cur - 1 >= 1 && b[cur - 1] != "__") cout << "        (covers " << str << " " << b[cur - 1] << ")" << endl;
            if(cur != r && b[cur] != "__") cout << "        (covers " << str << " " << b[cur] << ")" << endl; 
        }
        if(cur == r){
            for(int i = l; i <= r; i++){
                b[i] = a[i];
            } 
            r++; cur = 0;
        }
    }
    string prev = "\0";
    while(cin >> str){
        //cout << str << " " ;
        //cout << "        (deck " + str << ")" << endl;
        if(prev != "\0"){
            cout << "        (covers " << prev << " " << str << ")" << endl
            ;
        }
        prev = str;
    }
    return 0;
}
