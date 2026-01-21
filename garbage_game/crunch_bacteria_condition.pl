# crunch_bacteria_condition.pl
my $n = $ARGV[0];

# 必須得 chomp 檢查的
chomp($n);
die "ERROR\n" if $n =~ /[^0-9]/;

my $generations = 0;
my $count = 1;

while ($count < $n) {
    $count <<= 1; # *2
    $generations++;
}

print "過了 $generations 代，菌數達到 $count\n";

# 突(惡)發(搞)事件
my $event = rand();

if ($event < 0.01) { 
    $count = 0;
    print "培養基污染！菌數歸零！\n";
} 
elsif ($event < 0.02) {
    $count *= 10; 
    print "突變大爆發！菌數瞬間翻十倍，現在是 $count\n"; 
} 
elsif ($event < 0.03) {
    print "停電！實驗中斷！\n";
    exit; 
}
elsif ($event < 0.04) {
    $count = 1;
    print "研究員打翻培養皿，只剩下一隻孤單的菌...\n";
}
elsif ($event < 0.05) {
    $count = int(rand(1000));
    print "外星人干預！菌數隨機變成 $count\n"; 
} 
elsif ($event < 0.06) {
    print "資源耗盡，菌數固定在 $count，不再成長。\n"; 
}
