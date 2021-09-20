INPUT_DIR=""
for i in $(ls $INPUT_DIR/*.faa | sed 's/\.faa//g' | sed 's/^.*\///g');
do
	makeblastdb -in $INPUT_DIR/$i.faa -dbtype prot -out $i;
	echo -e 'qseqid\tsseqid\tqstart\tqend\tsstart\tsend\tevalue\tscore' > $i.tab;
	blastp \
	-query 28_OBPs.fasta \
	-db $i \
	-seg yes \
	-soft_masking true \
	-outfmt '6 qseqid sseqid qstart qend sstart send evalue score' >> $i.tab;
done
