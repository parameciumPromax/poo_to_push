# 自動抓取圖片並下載
curl -s https://example.com | grep -Eho "https?://[^ ]+\.(jpg|png|gif)" | xargs -n 1 curl -O

# 碰到referer限制
curl -e
https://example.com/page.html  -0
https://example.com/photo.jpg

# 斷點續傳(自動從斷掉地方繼續)
curl -C - -0 https://example.com/large -image.tiff

# 限速版本(模仿人類)
curl --limit-rate 500k -0 https://example.com/huge-photo.jpg
