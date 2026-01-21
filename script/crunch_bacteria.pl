# crunch_bacteria.pl

my $n = $ARGV[0];

# 必須得chomp檢查的
chomp ($n);
die "ERROR" if $n =~ /[^0-9]/; # 檢查輸入是否含有數字以外成分

my $generations = 0;
my $count = 1;

while ($count < $n){
	$count <<= 1; # *2
	$generations++;
}

print "過了 $generations 代，雖然根本沒考慮資源限制，請參見細菌生長趨勢圖in微生物學\n";

# 人類無聊時能做幾個無聊玩意