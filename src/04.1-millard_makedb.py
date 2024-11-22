import os
import subprocess

cmd1 = "/Users/zhudx/ncbi-blast/bin/makeblastdb -in inputs/millard_20241106/genomes_excluding_refseq.fa -input_type fasta -dbtype nucl -title millard_november -out inputs/blast_db/millard_db"
subprocess.run(cmd1, shell = True)