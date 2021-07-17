#!/bin/bash
genome=$1
btk_csv=$2
id=$3

# select which ones to investigate in btk viewer, save as csv in excel(otherwise true is lowercase and messes with things....)
# full path to genome
wd=`pwd`

grep -i TRUE $btk_csv | perl -F, -ane '$F[-1]=~s/"//g;print $F[-1]' > $id.ids

mkdir -p $wd/$id

python $wd/get_scaffolds.py $id.ids $genome > $wd/$id/$id.blast_scaffolds.fa

cd $wd/$id

python $wd/multif_to_singlef.py $wd/$id/$id.blast_scaffolds.fa

for f in *.fasta
do 
	curl -T $f http://172.27.25.136:35227 > $f.blast_out
done

# for f in *.fasta; do python "$wd"/btk_blast.py $f $f.blast.xml 0.04 > $f.blast.out; done

cd $wd
