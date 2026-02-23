#include <iostream>
#include <random>
#include <ctime>
#include <vector>

//賭徒模擬器
/*說明：紅黑輪盤中有兩格綠色，一個00和一個0，讓莊家53%賭徒47%
平均幾場會破產?幾場會贏到1000元?幾場會輸光?
###########################################

問題討論:
1.聽起來沒差耶?
A:莊家以量取勝，只要來的人多穩賺不賠

2.我能贏嗎?
A:花的時間和投入金錢越多，離破產越近，除非你有無限的資金和時間，否則最終還是會破產

3.機率差3%而已?
A:這個機率差不起眼但會被或然率放大

4.我能從中學到什麼?
A:不要賭博

5.真的沒辦法了嗎?
A:機率差大沒優勢，機率差小的還有機會(比如這個)

6.你為甚麼要用AI來模擬這個問題?
A:我覺得很有趣，沒辦法擅自推測擅自期待的隨機

7.mt19937是什麼?
A:mt19937是一種高品質的隨機數生成器，基於梅森旋轉算法，具有很長的周期和良好的統計特性，非常適合用於模擬和隨機過程。
蒙地卡羅模擬中常用來生成隨機數，確保模擬結果的可靠性和準確性。

8.為什麼要模擬這個問題?
A:兄長大人最近在跑蒙地卡羅模擬我被感染了

9.為甚麼不順便輸出圖表?
A:下次一定

##########################################
*/

int main() {
    std::mt19937 gen(time(0)); 
    std::uniform_real_distribution<> dis(0.0, 1.0);

    double win_rate = 0.47;     // 玩家勝率
    int initial_capital = 100;  // 本金
    int goal = 1000;            // 目標
    int total_trials = 1000;    // 模擬次數

    int bankrupted = 0;
    int reached_goal = 0;

    long long total_rounds_bankrupt = 0;
    long long total_rounds_goal = 0;

    std::cout << "開始模擬 " << total_trials << " 個賭徒的命運..." << std::endl;

    for (int i = 0; i < total_trials; ++i) {
        int cash = initial_capital;
        int rounds = 0;

        while (cash > 0 && cash < goal) {
            if (dis(gen) < win_rate) {
                cash++;
            } else {
                cash--;
            }
            rounds++;
        }

        if (cash <= 0) {
            bankrupted++;
            total_rounds_bankrupt += rounds;
        } else if (cash >= goal) {
            reached_goal++;
            total_rounds_goal += rounds;
        }
    }

    std::cout << "--- 實驗結果 ---" << std::endl;
    std::cout << "起始資金: " << initial_capital << " | 目標: " << goal << std::endl;
    std::cout << "勝率: " << win_rate * 100 << "% (莊家優勢 6%)" << std::endl;
    std::cout << "破產人數: " << bankrupted << " / " << total_trials << std::endl;
    std::cout << "達成目標人數: " << reached_goal << " / " << total_trials << std::endl;

    if (bankrupted > 0) {
        std::cout << "平均破產場數: " 
                  << (double)total_rounds_bankrupt / bankrupted << std::endl;
    }
    if (reached_goal > 0) {
        std::cout << "平均達成目標場數: " 
                  << (double)total_rounds_goal / reached_goal << std::endl;
    }

    std::cout << "破產率: " << (double)bankrupted / total_trials * 100 << "%" << std::endl;
    std::cout << "成功率: " << (double)reached_goal / total_trials * 100 << "%" << std::endl;

    return 0;
}
