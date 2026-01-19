#include<vector>
#include <string>
#include <sstream>
//perl style split 分割字串
std::vector <std::string> split(const std::string &s, char delimiter){
    std::vector <std::string> tokens;
    std::string token;
    std::istringstream tokenStream(s);
    while (std::getline(tokenStream, token, delimiter)){
        tokens.push_back(token);
    }
    return tokens;
}