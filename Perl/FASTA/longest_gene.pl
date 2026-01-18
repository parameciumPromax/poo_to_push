# 讀取染色體序列檔 (FASTA 格式)，假設檔名為 yeast_chr1.fasta
$input_file  = $ARGV[0] or die "Usage: perl longest_gene.pl <input_file>";
$output_file = "yeast_chr1_gene.fasta";

# 讀取 DNA 序列
open(INPUT,"<", $input_file) or die "Cannot open $input_file: $!";
my $sequence = "";
while (<INPUT>) {
    chomp;
    next if /^>/;   # 跳過FASTA標頭
    $sequence .= $_;
}
close INPUT;

# 找出所有可能的基因片段
@genes = ();
@starts = ();
for ($i = 0; $i < length($sequence) - 2; $i++) {
    if (substr($sequence, $i, 3) eq "ATG") {
        push @starts, $i;
    }
}

foreach $start (@starts) {
    $stop = index($sequence, "TAA", $start);
    if ($stop != -1) {
        $gene = substr($sequence, $start, $stop - $start + 3);
        push @genes, $gene;
    }
}

# 取出最長的基因序列
$longest_gene = "";
foreach $g (@genes) {
    if (length($g) > length($longest_gene)) {
        $longest_gene = $g;
    }
}

# 本段為測試用，後予以刪除
if ($longest_gene) {
    print "Longest gene saved to $output_file\n";
    print "Found gene sequence:\n$longest_gene\n";
} else {
    print "No gene found with ATG...TAA\n";
}


# 輸出成 FASTA 格式
if ($longest_gene) {
   open(OUTPUT, ">", $output_file) or die "Cannot write $output_file: $!";
   print OUTPUT ">yeast_chr1_longest_gene\n";
   print OUTPUT "$longest_gene\n";
   close OUTPUT;
   print "Longest gene saved to $output_file\n";
} else {
   print "No gene found with ATG...TAA\n";
}
