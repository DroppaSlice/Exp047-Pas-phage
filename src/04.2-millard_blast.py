import os
import subprocess

cmd1 = "/Users/zhudx/ncbi-blast/bin/blastn -db inputs/blast_db/millard_db -query inputs/pas_sRNAs.fasta -outfmt \"6 qseqid sseqid pident length qcovs qstart qend sstart send evalue bitscore qseq sseq\" -max_target_seqs 5000 -out outputs/millard_pas_blast.txt"
subprocess.run(cmd1, shell = True)