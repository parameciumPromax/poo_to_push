@num = (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49);
print"樂透號碼:","@num\n","請輸入你要的號碼個數:";
$length = @num;
$num1 = <STDIN>;
chomp($num1);
for ($i = 1; $i <= $num1; $i++) {
    $rand_num = int(rand($length));
		print "您抽出的號碼: $num[$rand_num]\n";

    for ($j = $rand_num; $j < $length-1; $j++){
        $num[$j] = $num[$j+1];
    }
	$length--;
}
