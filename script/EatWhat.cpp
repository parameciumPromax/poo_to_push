#include <iostream>  //老子是big5
#include <vector>
#include <cstdlib>
#include <ctime>
using namespace std;

int main() {
    vector<string> options = {"源一", "全家麵包", "全家微波", "自己"};
    srand((unsigned)time(NULL));
    int index = rand() % options.size();
    cout << "今天吃：" << options[index] << endl;

    cout << "按 Enter 鍵關閉視窗..." << endl;
    cin.get();
 // 按任意鍵再關閉視窗
    return 0;
}