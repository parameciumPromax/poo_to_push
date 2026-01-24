# 抓 HTML </p> 前 <p> 後的文字。非靜態內容不能抓
curl -sL https://example.com | grep -oP '(?<=<p>).*?(?=</p>)'



# 假裝是正規瀏覽器
curl curl -sL -A "Mozilla/5.0" https://example.com/



# 用lynx抽文字內容
lynx -dump https://example.com/ | grep "關鍵字"