# BLASTP All vs All
INPUT='sequence.faa'
OUTPUT='output.tab'
#dos2unix *;
makeblastdb -in $INPUT -dbtype prot -out db;
echo -e 'qseqid\tsseqid\tpident\tlength\tqstart\tqend\tsstart\tsend\tevalue\tscore' > $OUTPUT;
blastp -query sequence.faa -num_threads 3 -db db -seg yes -soft_masking true -outfmt '6 qseqid sseqid pident length qstart qend sstart send evalue score' >> $OUTPUT;