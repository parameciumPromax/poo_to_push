$file = $ARGV[0];

open (INPUT,"$file");

$one_line = "";
while($line = <INPUT>){
	chomp $line;
	if ($line=~/^>/){
	}
	else{
		$one_line = $one_line.$line;
	}
}
close INPUT;

$longest_seq = "";
while($one_line =~ /ATG(\w)*?TAA/g){   #ATG：固定字串，代表起始密碼子。(\w)*?：零個或多個「字母、數字或底線」字元，非貪婪匹配。
                                     #這裡通常用來代表基因序列中的任意字母。TAA：固定字串，代表終止密碼子。/g  表示全域搜尋，會找出字串中所有符合的片段，而不只第一個。
	$seq = $&;
	$len = length($seq);
	if ($len%3 == 0){
		if($len > length($longest_seq)){
			$longest_seq = $seq;
		}
	}
}