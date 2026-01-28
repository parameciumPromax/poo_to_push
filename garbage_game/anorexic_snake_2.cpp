// anorexic_snake_2.cpp
#include <iostream>
#include <deque>
#include <thread>
#include <chrono>    // 螢幕刷新
#include <conio.h>   // Windows 下用來讀鍵盤輸入
#include <cstdlib>
#include <ctime>

struct Point { int x, y; };
std::deque<Point> snake;
Point food;

const int WIDTH = 40;
const int HEIGHT = 20;

int dx = 1, dy = 0; // 初始方向：往右
bool running = true;

void spawn_food() {              // void 的意思是不！回傳！值！不return任何東西
    food.x = rand() % WIDTH;
    food.y = rand() % HEIGHT;
}

void draw() {
    std::cout << "\033[H"; // 清空螢幕
    for (int y = 0; y < HEIGHT; y++) {
        for (int x = 0; x < WIDTH; x++) {
            if (food.x == x && food.y == y) {
                std::cout << "\e[31m*\e[0m"; // 紅色食物
            } else {
                bool printed = false;
                for (auto &p : snake) {
                    if (p.x == x && p.y == y) {
                        std::cout << "\e[32mO\e[0m"; // 編碼真噁心
                        printed = true;
                        break;
                    }
                }
                if (!printed) std::cout << ".";
            }
        }
        std::cout << "\n";
    }
    std::cout << "Length: " << snake.size() << " | Press 'q' to quit" << std::endl;
}

void move_snake() {
    Point head = snake.front();
    Point next = {head.x + dx, head.y + dy};

    // 邊界處理：環狀場地
    if (next.x >= WIDTH) next.x = 0;
    if (next.x < 0) next.x = WIDTH-1;
    if (next.y >= HEIGHT) next.y = 0;
    if (next.y < 0) next.y = HEIGHT-1;

    snake.push_front(next);

    if (next.x == food.x && next.y == food.y) {
        // 厭食蛇：吃到食物反而變短
        if (snake.size() > 1) snake.pop_back();
        if (snake.size() > 1) snake.pop_back();
        spawn_food();
    } else {
        // 沒吃到食物 → 正常移動
        if (!snake.empty()) snake.pop_back();
    }

    if (snake.empty()) {
        std::cout << "Snake died (too anorexic!)" << std::endl;
        running = false;
    }
    // 在 move_snake() 裡檢查
    for (size_t i = 1; i < snake.size(); i++) { // 從 1 開始，避免跟自己頭比
        if (snake[i].x == next.x && snake[i].y == next.y) {
        std::cout << "Game Over!\n";
        running = false;
            return;
        }
    }
    
}


void handle_input() {
    if (_kbhit()) {
        char c = _getch();
        if (c == 'w') { dx = 0; dy = -1; }
        else if (c == 's') { dx = 0; dy = 1; }
        else if (c == 'a') { dx = -1; dy = 0; }
        else if (c == 'd') { dx = 1; dy = 0; }
        else if (c == 'q') { // 離開遊戲
            std::cout << "You quit the game." << std::endl;
            running = false;
        }
    }
}

int main() {
    // 初始化蛇
    snake.push_back({7,5});
    snake.push_back({6,5});
    snake.push_back({5,5});
    snake.push_back({4,5});
    snake.push_back({3,5});
    spawn_food();

    while (running) {
        handle_input();
        move_snake();
        draw();
        std::this_thread::sleep_for(std::chrono::milliseconds(200)); // 是要閃瞎人？
    }

    std::cout << "Game Over. Thanks for playing!" << std::endl;
    return 0;
}
