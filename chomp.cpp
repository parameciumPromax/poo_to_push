#include <iostream> //perlstyle chomp function，我有換行創傷
#include <string>   //用fasta導致的
int chomp(std::string &str){
    if (str.empty()) return 0;
    int removed = 0;
    size_t len = str.length();
    if (str[len - 1] == '\n') {
        if (len >= 2 && str[len - 2] == '\r') {
            str.erase(len - 2);
            removed = 2;
        } else {
            str.erase(len - 1);
            removed = 1;
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