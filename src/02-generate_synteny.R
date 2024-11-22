library(DECIPHER)
library(stringr)
library(cowplot)

phage_path <- "inputs/phage_genomes"
prophage_path <- "inputs/prophages"

phage_files <- list.files(path = phage_path, pattern = ".fasta", full.names = T)
names(phage_files) <- str_remove(list.files(path = phage_path, pattern = ".fasta"), ".fasta")
prophage_files <- list.files(path = prophage_path, pattern = ".fasta", full.names = T)
names(prophage_files) <- str_remove(list.files(path = prophage_path, pattern = ".fasta"), ".fasta")

db <- dbConnect(SQLite(), ":memory:")
synteny_list <- list()
alignments_list <- list()

for (i in 1:length(phage_files)){
  fas <- c(phage_files[i], prophage_files)
  
  for (i in seq_along(fas)) { 
    Seqs2DB(fas[i],
            type = "FASTA",
            db,
            tblName = names(fas[1]),
            identifier = names(fas[i]))
  }
  
  synteny_list[[names(fas[1])]] <-  FindSynteny(dbFile = db,
                                                tblName = names(fas[1]),
                                                verbose = T)
  alignments_list[[names(fas[1])]] <- AlignSynteny(synteny = synteny_list[[names(fas[1])]],
                                                   db = db,
                                                   tblName = names(fas[1]))
}

for(i in 1:length(synteny_list)){
  pairs(synteny_list[[i]], boxBlocks=T)
  plot(synteny_list[[i]])
}