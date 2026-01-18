# 地圖需要轉成矩陣，因為電腦是呆子
module ImagesMap
using Images, FileIO, Colors

img = load("map_2.png")
h, w = size(img)

function color_to_code(c)
    c_rgb = RGB(c)   # 統一轉成 RGB
    if isapprox(c_rgb, RGB(1,0,0); atol=0.01)
        return 9
    elseif isapprox(c_rgb, RGB(0.5,0.5,0.5); atol=0.01)
        return 1
    elseif isapprox(c_rgb, RGB(0,0,0); atol=0.01)
        return 1
    elseif isapprox(c_rgb, RGB(0,1,0); atol=0.01)
        return 2
    else
        return 0
    end
end

grid = [color_to_code(img[y,x]) for y in 1:h, x in 1:w]

end
