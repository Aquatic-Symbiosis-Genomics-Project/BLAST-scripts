[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?style=flat-square)](https://crystal-lang.org/)
[![CI](https://github.com/Aquatic-Symbiosis-Genomics-Project/BLAST-scripts/actions/workflows/ci.yml/badge.svg)](https://github.com/Aquatic-Symbiosis-Genomics-Project/BLAST-scripts/actions?query=workflow%3ACI)
[![Latest Release](https://img.shields.io/github/v/release/Aquatic-Symbiosis-Genomics-Project/BLAST-scripts.svg)](https://github.com/Aquatic-Symbiosis-Genomics-Project/BLAST-scripts/releases)
# BLAST-scripts
Scripts for automated blast searches from btk from downloaded tables with a selection. It will only blast the sequences selected in BTK.

## releases
[linux x86_64 crystal binary](https://github.com/:username/:reponame/releases/latest)

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
- decon_blastBTK
- scaffold_assembly.fasta
- btk.csv
