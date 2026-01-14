print"遇到了甚麼問題?\n";
print"1.Use of uninitialized value $var in division (/)\n
2.Name \"main::foo\" used only once: possible typo\n
3.Unquoted string \"bar\" may clash with future reserved word\n
4.Odd number of elements in hash assignment\n
5.Argument \"baz\" isn't numeric in division (/)\n";
my $input = <STDIN>;
if ($input == 1){
	print ("你嘗試用一個尚未賦值的變數進行數學運算");
}
elsif ($input == 2){
	print ("懷疑你打錯了變數名，因為它只出現一次");
}
 elsif($input == 3){
	print ("建議你加上引號以避免未來衝突");
}
 elsif($input == 4){
	print ("雜湊需要成對的鍵值，但你給了奇數個元素，可能漏了某個值");
}
elsif ($input == 5){
	print ("你用了一個非數字的字串進行除法");
}
else{
	print("這裡沒有你想要的東西");
} 