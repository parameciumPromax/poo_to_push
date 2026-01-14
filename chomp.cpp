#include <iostream> //perlstyle chomp function，我有換行創傷
#include <string>   //用fasta導致的
// 每一行都刪
int chomp(std::string &str){
    int removed = 0;
    while (!str.empty()) {
        if (str.back() == '\n') {
            str.pop_back();
            removed++;
            if (!str.empty() && str.back() == '\r') {
                str.pop_back();
                removed++;
            }
        } else if (str.back() == '\r') {
            str.pop_back();
            removed++;
        } else {
            break;
        }
    }
    return removed;
}
//這下面是測試，要複製時不需要這裡
int main(){
    std::string test1 = "Hello, World!\n";
    std::string test2 = "Hello, World!\r\n";
    std::string test3 = "Hello, World!";
    
    std::cout << "Removed from test1: " << chomp(test1) << ", Result: '" << test1 << "'" << std::endl;
    std::cout << "Removed from test2: " << chomp(test2) << ", Result: '" << test2 << "'" << std::endl;
    std::cout << "Removed from test3: " << chomp(test3) << ", Result: '" << test3 << "'" << std::endl;
    
    return 0;
}