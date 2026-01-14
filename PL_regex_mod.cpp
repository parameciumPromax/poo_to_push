#define PCRE2_CODE_UNIT_WIDTH 8
#include <pcre2.h> // 記得 g++ PL_regex_mod.cpp -o app.exe -lpcre2-8
#include <string>
#include <string>
 /*複製這一段*/
 std::string subject = "Your text here 123";
 std::string pattern = R"(\d+)";  //PL regex style
 int errornumber;
    PCRE2_SIZE erroroffset;
//編譯(懶惰不用option)
pcre2_code*re = pcre2_compile(  // 以下為intellisense 自作多情註解
    (PCRE2_SPTR)pattern.c_str(),               // the pattern
    PCRE2_ZERO_TERMINATED, // indicates pattern is zero-terminated
    0,                     // default options
    &errornumber,         // for error number
    &erroroffset,        // for error offset
    NULL);                // use default compile context
if (re){
    pcre2_match_data*match_data = pcre2_match_data_create_from_pattern(re, NULL);
    //執行比對，以下為intellisense 自作多情註解
    int rc = pcre2_match(re(PCRE_SPTR)subject.c_str(), subject.length(), 0, 0, match_data, NULL);
    if (rc > 0){
        PCRE2_SIZE*ovector = pcre2_get_ovector_pointer(match_data);
        for (int i = 0; i < rc; i++) {
            std::string match_str = subject.substr(ovector[2 * i], ovector[2 * i + 1] - ovector[2 * i]);
            std::cout << "Match " << i << ": " << match_str << std::endl;
        }
    }
    pcre2_match_data_free(match_data);
    pcre2_code_free(re);
}
/*結束複製*/