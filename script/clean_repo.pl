use strict;
use warnings;

my $filename = 'input.html';
open(my $fh, '<', $filename) or die "cannot find the file $!";
my $content = do { local $/; <$fh> };
close($fh);

# 移除圖片相關標籤與 style 屬性
$content =~ s/<img.*?>//gi; # 圖片標籤
$content =~ s/<source.*?>//gi ; # 來源標籤
$content =~ s/<picture.*?>|<\/picture>//gi; # 圖片容器
$content =~ s/style=".*?"//gi; # CSS行內樣式

# 輸出結果
open(my $out, '>', 'clean_version.html') or die "cannot save the file: $!";
print $out $content;
close($out);
