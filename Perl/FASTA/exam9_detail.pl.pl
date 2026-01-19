# Perl 程式：尋找 DNA 三個閱讀框中最長的 ATG...TAA 區段，並輸出到 gene.fasta
# -------------------------------------------------------------
# 本程式會：
# 1. 讀取一個 DNA FASTA 檔案（只支援單一序列，忽略標頭行 >）
# 2. 將 DNA 拉直成一行字串
# 3. 對三個閱讀框（frame 1, 2, 3）分別切割成密碼子（每三個字元一組）
# 4. 在每個閱讀框中尋找從 ATG 開始、TAA 結束的最長片段（不重疊）
# 5. 將三個閱讀框中最長的片段輸出到 gene.fasta，每 60 字元換行
# -------------------------------------------------------------

# 取得輸入檔案名稱（從命令列參數）
$file = $ARGV[0];

# 初始化 DNA 字串，稍後會存放整條序列
$dna = "";

# 讀取 FASTA 檔案內容
open (INPUT, $file); # 開啟檔案供讀取
while ($line = <INPUT>) {
    chomp $line; # 去除換行符號
    if ($line =~ /^>/) {
        # 如果是標頭行（以 > 開頭），跳過不處理
    } else {
        $dna .= $line; # 將序列內容接到 $dna 字串後面
    }
}
close INPUT; # 關閉檔案

# 初始化三個閱讀框的最長序列及長度
($max_seq1, $max_len1) = ("", 0); # 閱讀框1
($max_seq2, $max_len2) = ("", 0); # 閱讀框2
($max_seq3, $max_len3) = ("", 0); # 閱讀框3

# ========== 閱讀框 1 ========== #
# 不偏移，直接從第一個字元開始切割
$current_dna1 = $dna;
# 將 DNA 切割成每三個字元一組的密碼子陣列
@codons_dna1 = $current_dna1 =~ /.{3}/g;
$len1 = @codons_dna1;  # 密碼子總數
# 逐一檢查每個密碼子
for ($i = 0; $i < $len1; $i++) {
    if ($codons_dna1[$i] eq "ATG") { # 如果遇到起始密碼子 ATG
        $found_seq = "ATG";        # 新增一個暫存字串，先放入 ATG
        # 往後找直到遇到 TAA 為止
        for ($j = $i + 1; $j < $len1; $j++) {
            $found_seq .= $codons_dna1[$j]; # 每次加一個密碼子
            if ($codons_dna1[$j] eq "TAA") { # 如果遇到終止密碼子 TAA
                $found_len = length($found_seq); # 計算這段序列長度
                if ($found_len > $max_len1) { # 如果比目前最長還長
                    $max_len1 = $found_len;   # 更新最長長度
                    $max_seq1 = $found_seq;   # 更新最長序列
                }
                last; # 找到一段就跳出內層迴圈
            }
        }
    }
}

# ========== 閱讀框 2 ========== #
# 偏移 1 個鹼基（在前面加一個 C，模擬 frame2）
$current_dna2 = "C" . $dna;
@codons_dna2 = $current_dna2 =~ /.{3}/g;
$len2 = @codons_dna2;
for ($i = 0; $i < $len2; $i++) {
    if ($codons_dna2[$i] eq "ATG") {
        $found_seq = "ATG";
        for ($j = $i + 1; $j < $len2; $j++) {
            $found_seq .= $codons_dna2[$j];
            if ($codons_dna2[$j] eq "TAA") {
                $found_len = length($found_seq);
                if ($found_len > $max_len2) {
                    $max_len2 = $found_len;
                    $max_seq2 = $found_seq;
                }
                last;
            }
        }
    }
}

# ========== 閱讀框 3 ========== #
# 偏移 2 個鹼基（在前面加兩個 C，模擬 frame3）
$current_dna3 = "CC" . $dna;
@codons_dna3 = $current_dna3 =~ /.{3}/g;
$len3 = @codons_dna3;
for ($i = 0; $i < $len3; $i++) {
    if ($codons_dna3[$i] eq "ATG") {
        $found_seq = "ATG";
        for ($j = $i + 1; $j < $len3; $j++) {
            $found_seq .= $codons_dna3[$j];
            if ($codons_dna3[$j] eq "TAA") {
                $found_len = length($found_seq);
                if ($found_len > $max_len3) {
                    $max_len3 = $found_len;
                    $max_seq3 = $found_seq;
                }
                last;
            }
        }
    }
}

# ========== 輸出結果到 gene.fasta ========== #
open (OUTPUT, ">gene.fasta"); # 開啟輸出檔案

# 輸出閱讀框 1 最長序列，每 60 字元換行
print OUTPUT ">Readingframe1\n"; # 標頭
$seq_len = length $max_seq1; # 取得序列長度
for ($i = 0; $i < $seq_len; $i += 60) {
    $line = substr($max_seq1, $i, 60); # 每 60 字元切一行
    print OUTPUT "$line\n";
}

# 閱讀框 2
print OUTPUT ">Readingframe2\n";
$seq_len = length $max_seq2;
for ($i = 0; $i < $seq_len; $i += 60) {
    $line = substr($max_seq2, $i, 60);
    print OUTPUT "$line\n";
}

# 閱讀框 3
print OUTPUT ">Readingframe3\n";
$seq_len = length $max_seq3;
for ($i = 0; $i < $seq_len; $i += 60) {
    $line = substr($max_seq3, $i, 60);
    print OUTPUT "$line\n";
}

close OUTPUT; # 關閉輸出檔案

# 程式結束
