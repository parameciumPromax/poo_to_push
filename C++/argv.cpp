#include <iostream>  //好想 $doc = $ARGV[0]; 
#include <string>
int main(int argc, char* argv[]){
    if(argc < 2){
        std::cerr << "Please provide a string argument." << std::endl; //花裡胡哨
        return 1; //1代表錯誤
    }
    std::string input = argv[1];
    std::cout << "You provided: " << input << std::endl;
}
// (argc>1) || (std::cerr << "Please provide a string argument." << argv[0], exit(1)); 邪門寫法