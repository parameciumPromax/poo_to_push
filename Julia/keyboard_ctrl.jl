# 用鍵盤控制

module KeyboardCtrl

export run_game

player = (2,2)

function move_player(player, dir)
    x, y = player
    if dir == 'w'        # 上
        return (x-1, y)
    elseif dir == 's'    # 下
        return (x+1, y)
    elseif dir == 'a'    # 左
        return (x, y-1)
    elseif dir == 'd'    # 右
        return (x, y+1)
    else
        return player    # 無效輸入 → 不動
    end
end

function run_game()
    player = (2,2)
    while true
        println("玩家位置: ", player)
        print("輸入方向 (w/a/s/d): ")
        dir = readline()[1]   # 讀取一個字元
        player = move_player(player, dir)
    end
end

end
