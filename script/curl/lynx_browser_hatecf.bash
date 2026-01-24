# 警告！後果自負

# 使用方式：
# ./proxy_lynx.sh <目標網址> [翻譯語言]
# 預設翻譯語言是 zh-TW (繁體中文)

TARGET="$1"
LANG="${2:-zh-TW}"

if [ -z "$TARGET" ]; then
  echo "請提供目標網址，例如： ./proxy_lynx.sh https://www.dcard.tw/f"
  exit 1
fi

# 建立 Google 翻譯代理 URL
PROXY_URL="https://translate.google.com/translate?sl=auto&tl=$LANG&u=$TARGET"

lynx -useragent="Mozilla/5.0" -accept_all_cookies -dump "$PROXY_URL"

# 想看dcard的可以放棄了，代理訪問都行不通。只想看文章怎麼打起攻防了