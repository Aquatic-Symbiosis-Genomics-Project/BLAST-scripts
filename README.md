# BLAST-scripts

Scripts for automated blast searches from btk


#Ran like this: <br /> <br /> <br />

    bsub -o btk_blast_test.o -e btk_blast_test.e  -n 6 -M10000 -R"select[mem>10000] rusage[mem=10000] span[hosts=1]"             /lustre/scratch123/tol/teams/grit/ce9/decon_blasts/decon_blastBTK.sh idCriBerb1.PB.asm2.purge1.polish1.scaff1.fa idCriBerb_primary.csv idCriBerb

#Usage <br /> <br /> <br />

For now, put in working dir:
- get_scaffolds.py
- multif_to_singlef.py
- decon_blastBTK.sh
- scaffold_assembly.fasta
- btk.csv
