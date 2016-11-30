#include <iostream>

using namespace std;

int main(){
    freopen("output.txt", "w", stdout);
    for(int i = 0; i <= 13; i++){
        int f = i, s = 13 - i;
        cout << "(sum-equal-13 n" << f << " n" << s << ")" << endl;
    }
    return 0;
}
