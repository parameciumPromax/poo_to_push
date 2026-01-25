# perl 啟動，刪網頁圖
perl -pe 's/<img.*?>//gi; s/<source.*?>//gi; s/background-image:.*?;//gi'imput.html > no_images.html
