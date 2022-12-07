# BLAST-scripts
Scripts for automated blast searches from btk from downloaded tables with a selection. It will only blast the sequences selected in BTK.

## Run like this: 
bash decon_blastBTK.sh ASSEMBLY.FA BTK.CSV WORKDIRECTORY

or (the crystal version)
./decon_blastBTK -f ASSEMBLY.FA -b BTK.csv -o WORKDIRECTORY

## Usage 
For now, put in working dir:
- get_scaffolds.py
- multif_to_singlef.py
- decon_blastBTK.sh
- scaffold_assembly.fasta
- btk.csv
or (for the crystal version)
- decon_blastBTK.cr
- scaffold_assembly.fasta
- btk.csv
