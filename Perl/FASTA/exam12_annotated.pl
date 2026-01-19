# exam12_annotated.pl
# 這個程式會讀取 DNA FASTA 檔案，找出三個閱讀框中最長的 ATG...TAA 區段，並輸出到 gene.fasta

# 取得輸入檔案名稱 (第一個命令列參數)
$file = $ARGV[0];  # $file 儲存輸入的檔案名稱

# 初始化 DNA 字串
$dna = "";  # $dna 儲存完整 DNA 序列

# 讀取 FASTA 檔案，忽略標頭行 (以 > 開頭)，將序列資料串接成一條
open (INPUT, $file);  # 開啟輸入檔案，檔案代號為 INPUT
while ($line = <INPUT>) {  # 逐行讀取檔案內容，$line 為目前讀取的那一行
    chomp $line;  # 移除行尾換行字元
    if ($line =~ /^>/) {  # 如果這行是標頭 (以 > 開頭)
        # 跳過標頭行，不做任何事
    } else {
        $dna .= $line;  # 將序列資料接到 $dna 字串後面
    }
}
close INPUT;  # 關閉輸入檔案

# 初始化最長序列及長度的變數
$longest_seq = "";  # $longest_seq 儲存目前找到的最長序列
$longest_len = 0;    # $longest_len 儲存目前最長序列的長度

# 檢查三個閱讀框 (frame 0, 1, 2)
for ($frame = 0; $frame <= 2; $frame++) {
    $current_dna = substr($dna, $frame, length($dna) - $frame);  # $current_dna 為目前閱讀框的序列
    @codons = $current_dna =~ /.{3}/g;  # @codons 為密碼子陣列，每三個字元一組
    $len = @codons;  # $len 為密碼子數量

    for ($i = 0; $i < $len; $i++) {  # 逐一檢查每個密碼子
        if ($codons[$i] eq "ATG") {  # 如果遇到起始密碼子 ATG
            $found_seq = "ATG";  # $found_seq 儲存目前找到的序列
            for ($j = $i + 1; $j < $len; $j++) {  # 往後累加密碼子
                $found_seq .= $codons[$j];
                if ($codons[$j] eq "TAA") {  # 如果遇到終止密碼子 TAA
                    $found_len = length($found_seq);  # $found_len 為目前序列長度
                    if ($found_len > $longest_len) {  # 若比目前最長還長
                        $longest_len = $found_len;  # 更新最長長度
                        $longest_seq = $found_seq;  # 更新最長序列
                    }
                    last;  # 找到一段就跳出內層
                }
            }
        }
    }
}

# 輸出最長序列到 gene.fasta
open (OUTPUT, ">gene.fasta");  # 開啟輸出檔案
print OUTPUT ">longest_seq\n";  # 輸出 FASTA 標頭
$seq_len = length $longest_seq;  # $seq_len 為最長序列長度
for ($i = 0; $i < $seq_len; $i += 70) {  # 每 70 字元換行
    $line = substr($longest_seq, $i, 70);  # $line 為目前要輸出的 70 字元片段
    print OUTPUT "$line\n";  # 輸出片段
}
close OUTPUT;  # 關閉輸出檔案
