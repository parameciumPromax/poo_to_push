/*📖 使用方式
1.建立一個新的瀏覽器書籤。

2.替書籤命名，例如「刪除圖片」。

3.在 URL 欄位貼上上面的程式碼。

4.以後在任何網頁點擊這個書籤，就會把頁面上的所有圖片刪掉。*/


javascript:(function(){
  var i, t = document.getElementsByTagName('img');
  for (i = t.length - 1; i >= 0; i--) {
    t[i].parentNode.removeChild(t[i]);
  }
})();
