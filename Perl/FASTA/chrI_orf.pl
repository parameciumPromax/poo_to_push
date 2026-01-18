# 讀取染色體序列檔 (FASTA 格式)
my $input = shift @ARGV or die "請提供酵母菌染色體I的FASTA檔\n";
my $output = shift @ARGV || "chrI_orfs.fasta";

open my $in, "<", $input or die "無法開啟 $input: $!";
open my $out, ">", $output or die "無法建立 $output: $!";

# 讀取序列（忽略FASTA標題行）
my $seq = "";
while (<$in>) {
    chomp;
    next if /^>/;
    $seq .= $_;
}
close $in;

my $orf_count = 0;

# 掃描序列，尋找 ORF
for (my $i = 0; $i < length($seq); $i++) {
    # 找到 ATG
    if (substr($seq, $i, 3) eq "ATG") {
        my $longest_orf = "";
        # 從這個 ATG 開始往後找 TAA
        for (my $j = $i+3; $j < length($seq)-2; $j+=3) {
            my $codon = substr($seq, $j, 3);
            if ($codon eq "TAA") {
                my $orf = substr($seq, $i, $j-$i+3);
                if (length($orf) > length($longest_orf)) {
                    $longest_orf = $orf;
                }
                last; # 找到第一個終止密碼子就停止
            }
        }
        if ($longest_orf ne "") {
            $orf_count++;
            print $out ">ORF_$orf_count start=$i length=", length($longest_orf), "\n";
            print $out "$longest_orf\n";
        }
    }
}

close $out;
