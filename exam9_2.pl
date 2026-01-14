$file = $ARGV[0];
$dna= "";
# 1. 讀取並拉直 DNA
open (IN, $file);
while ($line=<IN>){
	chomp $line;
	if ($line=~/^>/){
	}
	else{
		$dna.=$line;
	}
}
close IN;

($max_seq1, $max_len1) = ("", 0);
($max_seq2, $max_len2) = ("", 0);
($max_seq3, $max_len3) = ("", 0);

# ===== 第一個閱讀框 =====
$current_dna1 = $dna;
@codons_dna1 = $current_dna1 =~ /.{3}/g;

$len1 = @codons_dna1;  # 不用 scalar()

for ($i = 0; $i < $len1; $i++) {
    if ($codons_dna1[$i] eq "ATG") {
        $found_seq = "ATG";
        $stop_found = 0;

        for ($j = $i + 1; $j < $len1; $j++) {
            $found_seq .= $codons_dna1[$j];
            
            if ($codons_dna1[$j] eq "TAA") {
                $found_len = length($found_seq);
                
                if ($found_len > $max_len1) {
                    $max_len1 = $found_len;
                    $max_seq1 = $found_seq;
                }
                $stop_found = 1;  # 標記已找到 stop codon
            }
        }

        # 不用 next，改成用 if 判斷
        if ($stop_found == 1) {
            # 這裡什麼都不做，迴圈自然繼續跑下一個 i
        }
    }
}

# ===== 第二個閱讀框 =====
$current_dna2 = $dna;
@codons_dna2 = $current_dna2 =~ /.{3}/g;

$len2 = @codons_dna2;  # 不用 scalar()

for ($i = 0; $i < $len2; $i++) {
    if ($codons_dna2[$i] eq "ATG") {
        $found_seq = "ATG";
        $stop_found = 0;

        for ($j = $i + 1; $j < $len2; $j++) {
            $found_seq .= $codons_dna2[$j];
            
            if ($codons_dna2[$j] eq "TAA") {
                $found_len = length($found_seq);
                
                if ($found_len > $max_len2) {
                    $max_len2 = $found_len;
                    $max_seq2 = $found_seq;
                }
                $stop_found = 1;  # 標記已找到 stop codon
            }
        }

        # 不用 next，改成用 if 判斷
        if ($stop_found == 1) {
            # 這裡什麼都不做，迴圈自然繼續跑下一個 i
        }
    }
}

# ===== 第三個閱讀框 =====
$current_dna3 = $dna;
@codons_dna3 = $current_dna3 =~ /.{3}/g;

$len3 = @codons_dna3;  # 不用 scalar()

for ($i = 0; $i < $len3; $i++) {
    if ($codons_dna3[$i] eq "ATG") {
        $found_seq = "ATG";
        $stop_found = 0;

        for ($j = $i + 1; $j < $len3; $j++) {
            $found_seq .= $codons_dna3[$j];
            
            if ($codons_dna3[$j] eq "TAA") {
                $found_len = length($found_seq);
                
                if ($found_len > $max_len3) {
                    $max_len3 = $found_len;
                    $max_seq3 = $found_seq;
                }
                $stop_found = 1;  # 標記已找到 stop codon
            }
        }
    }
}



# ===== 輸出結果 =====
open (my $OUT, ">final_regex.fasta");

if ($max_seq1) {
    print $OUT ">閱讀框1最長序列 (長度: $max_len1 bp)\n";
    for ($pos = 0; $pos < length($max_seq1); $pos += 70) {
        print $OUT substr($max_seq1, $pos, 70), "\n";
    }
}

if ($max_seq2) {
    print $OUT ">閱讀框2最長序列 (長度: $max_len2 bp)\n";
    for ($pos = 0; $pos < length($max_seq2); $pos += 70) {
        print $OUT substr($max_seq2, $pos, 70), "\n";
    }
}

if ($max_seq3) {
    print $OUT ">閱讀框3最長序列 (長度: $max_len3 bp)\n";
    for ($pos = 0; $pos < length($max_seq3); $pos += 70) {
        print $OUT substr($max_seq3, $pos, 70), "\n";
    }
}


close $OUT;

print "閱讀框 1: $max_seq1 (長度: $max_len1 bp)\n" if $max_seq1;
print "閱讀框 2: $max_seq2 (長度: $max_len2 bp)\n" if $max_seq2;
print "閱讀框 3: $max_seq3 (長度: $max_len3 bp)\n" if $max_seq3;
print "\n結果已寫入 final_regex.fasta\n";