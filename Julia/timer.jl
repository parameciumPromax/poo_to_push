# 倒數計時器

module Countdown

export start_timer

"啟動倒數計時，time 為總秒數或回合數"
function start_timer(time::Int)
    while time > 0
        println("剩餘時間: ", time)
        sleep(1)   # 每秒倒數一次，如果你用回合制可以拿掉
        time -= 1
    end
    println("倒數結束！")
end

end # module

