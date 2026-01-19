#include <vector>
#include <string>
//perl style join 合併字串，應該用不到。將vector內元素以delimiter連接成一字串回傳
inline std::string join(const std::vector<std::string> &elements, const std::string &delimiter){
    std::string result;
    for(size_t i = 0; i < elements.size(); i++){
        result += elements[i] + (i < elements.size() -1 ? delimiter : "");
    }
    return result;
}