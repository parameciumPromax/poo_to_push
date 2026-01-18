$file = $ARGV[0] or die "Usage: perl longest_orf.pl <input.fasta>\n";
open($IN, "<", $file) or die "Cannot open $file: $!";

$seq = "";
while ($line = <$IN>) {
    chomp $line;
    next if $line =~ /^>/;        # 跳過 FASTA 標頭
    $seq .= uc($line);            # 轉大寫，避免大小寫影響
}
close $IN;

$longest = "";
@orfs = ();                    # 若需要也可輸出全部 ORF

for ($i = 0; $i <= length($seq) - 3; $i++) {
    next unless substr($seq, $i, 3) eq "ATG";
    for ($j = $i + 3; $j <= length($seq) - 3; $j += 3) {
        $codon = substr($seq, $j, 3);
        if ($codon eq "TAA" || $codon eq "TAG" || $codon eq "TGA") {
            $orf = substr($seq, $i, $j - $i + 3);
            push @orfs, { start => $i, end => $j, seq => $orf };
            $longest = $orf if length($orf) > length($longest);
            last;                                                          # 只取距起點最近的同框架 stop
        }
    }
}

open($OUT, ">", "longest_gene.fasta") or die "Cannot write output: $!";
if ($longest ne "") {
    print $OUT ">longest_orf\n$longest\n";
    close $OUT;
    print "Longest ORF length: ", length($longest), "\n";
    print "Longest ORF sequence:\n$longest\n";
} else {
    print $OUT ">longest_orf\n";
    close $OUT;
    print "No in-frame ORF found.\n";
}

# 若要同時檢視所有 ORF（含位置），取消以下註解：
# open($ALL, ">", "all_orfs.tsv") or die $!;
# print $ALL "start\tend\tlength\tseq\n";
# for $o (@orfs) {
#     print $ALL $o->{start}, "\t", $o->{end}, "\t", length($o->{seq}), "\t", $o->{seq}, "\n";
# }
# close $ALL;
