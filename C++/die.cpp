#include <iostream>
#include <cstdlib>
#include <string>
//perl style die
void die(const std::string &message){
    std::cerr << message << std::endl;
    std::exit(1);
}