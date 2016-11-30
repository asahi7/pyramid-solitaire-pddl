#include <iostream>
#include <string>

using namespace std;

int main(){
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);
    string str;
    while(cin >> str){
        int n;
        if(str != "__"){
            if(str[1] >= '0' && str[1] <= '9'){
                n = str[1] - '0';
            }
            else if(str[1] == 'X') n = 10;
            else if(str[1] == 'J') n = 11;
            else if(str[1] == 'Q') n = 12;
            else if(str[1] == 'K') n = 13;
            else if(str[1] == 'A') n = 1;
            cout << "        (value " << str << " n" << n << ")" << endl;
        }
    }
    return 0;
}
