using Plots
# 造糞julia版，有圖。    Intellisense真的很吵，還是說是我被npp慣壞了？  
# 直接複製出了點意外，只好手打
function crunch_bacteria_plot(n::Int)
    count = 1
    generations = 0
    history = [count] # 紀錄每代數量

    while count < n 
        count *= 2 
        generations += 1
        push!(history, count)
    end

    println("過了 $generations 代，數量 $count")

    event = rand()
    if event < 0.1
        count = 0
        println("培養基汙染，歸零")
    elseif event < 0.2
        count *= 10
        println("突變大爆發，現在是 $count 個")
    elseif event < 0.3
        println("停電！實驗中斷")
        return    
    elseif event < 0.4
        count = 1
        println("培養基打翻，剩一個") 
    elseif event < 0.5
        count = rand(1:1000)
        println("外星人干預結果，數量變成 $count")
    elseif event < 0.6
        println("資源耗盡，數字不變")
    else
        println("無意外發生")
end
    p =plot(0:generations, history, # 印圖，Plot不支援中文
        xlabel="Generation",
        ylabel="Bacteria Count",
        title="Growth Curve",
        legend=false,
        lw=2,
        marker=:circle)
display(p)
savefig(p, "output.png")

end
# 讀取參數
if length(ARGS) > 0
    n = parse(Int, ARGS[1])
    crunch_bacteria_plot(n)
else
    println("請提供目標細菌數量作為參數")
end

# 警告！輸出圖檔會覆蓋同目錄下的output.png，請注意備份！