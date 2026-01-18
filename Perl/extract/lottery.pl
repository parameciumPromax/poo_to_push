#沒找到老師的email所以已經私訊moodle問
#先寫這樣等老師回

@num = (1..49); #樂透號碼1~49
print "樂透號碼: @num\n請輸入你要的號碼個數: ";
$length = @num; 
$num1 = <STDIN>;
chomp($num1);

$count = 0; #初始化變數，沒有也能跑不過-w的情況下會跳警告。
			#因為只用一次，所以會有提示消息std::count......是perl懷疑你變數只用一次是不是寫錯，可以不理會

#因為不能用while所以以下改用for來做
for ($i = 0; $i < $num1; $i++) {
    $rand_index = int(rand($length));
    $candidate = $num[$rand_index];

    if ($candidate > 0) {
        $num[$rand_index] = -$candidate; # 標記為已抽過
        $i--; # 抽到有效號碼才算一次，否則重抽
    }
}

print "您抽出的號碼:\n";
for ($j = 0; $j < $length; $j++) {
    if ($num[$j] < 0) {
        print -$num[$j], "\n"; # 還原成正數印出
    }
}
