$DNA_file=shift @ARGV;
open INPUT,"$DNA_file";
@file_line=<INPUT>;
#print "@file_line";
for ($i=0;$i<@file_line;$i++){
#print "$file_line[$i]";
@sequence=split(//,$file_line[$i]);
#print "@sequence";
for ($j=0;$j<@sequence;$j++){
#print "$sequence[$j]";
	$codon1=$sequence[$j];
	$codon2=$sequence[$j+1];
	$codon3=$sequence[$j+2];
#print "$codon1$codon2$codon3\t";
	$codon=$codon1.$codon2.$codon3;
#print "$codon\t";
if ($codon eq"ATG"){
	$number=$i+1;
	$site=$j+1-2;
print "DNA No.$number has genes and the start codon site is at $site"."th
nucleotide.\n";
print "The gene is: ";
for ($k=$j;$k<@sequence;$k++){
	print "$sequence[$k]";
}
print "\n";
#$gene=substr($file_line[$i],$j,(length $file_line[$i])-$j);
#print "$gene\n";
}
}
}
