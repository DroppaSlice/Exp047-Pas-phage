library(DECIPHER)
library(stringr)

phage_path <- "inputs/phage_genomes"
prophage_path <- "inputs/prophages"

phage_files <- list.files(path = phage_path, pattern = ".fasta", full.names = T)
names(phage_files) <- str_remove(list.files(path = phage_path, pattern = ".fasta"), ".fasta")
prophage_files <- list.files(path = prophage_path, pattern = ".fasta", full.names = T)
names(prophage_files) <- str_remove(list.files(path = prophage_path, pattern = ".fasta"), ".fasta")

db <- dbConnect(SQLite(), ":memory:")

for (i in seq_along(phage_files)){
  Seqs2DB(phage_files[i],
          type = "FASTA",
          db,
          identifier = names(phage_files[i]),
          tblName = "phages"
  )
}


for (i in seq_along(prophage_files)){
  Seqs2DB(prophage_files[i],
          type = "FASTA",
          db,
          identifier = names(prophage_files[i]),
          tblName = "prophages"
  )
}

phage_synteny <- FindSynteny(dbFile = db,
                             tblName = "phages",
                             verbose = T)

prophage_synteny <- FindSynteny(dbFile = db,
                             tblName = "prophages",
                             verbose = T)

pairs(phage_synteny, boxBlocks = T)
pairs(prophage_synteny, boxBlocks = T)