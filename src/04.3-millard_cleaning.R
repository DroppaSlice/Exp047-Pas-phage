library(readr)
library(dplyr)
library(tidyr)

#-----read in the blast results using the read_tsv() function from the readr package-----#
millard_blast <- read_tsv(file = "outputs/millard_pas_blast.txt",
                          col_names = c("qseqid", "sseqid", "pident", "length", "qcovs", "qstart", "qend", "sstart", "send", "evalue", "bitscore", "qseq", "sseq")) %>% 
  mutate(qseqid = factor(qseqid))

#-----filtering steps-----#
#writing a homolog filtering function specifically for distinguishing pasA1/A2 and pasD1/D2 homologs
#inputs are a data frame containing blast results with both a 'pident' column and a column (default 'qseqid') holding pasA1/A2 info
pas_filter <- function(blast_results, id_col = "qseqid", a.limit = 95, d.limit = 98){
  list <- split(blast_results, f = blast_results[,id_col])
  homologs <- c("pasA1", "pasA2", "pasD1", "pasD2")
  for(gene in homologs){
    #filter pasA1 and pasA2 dfs for >= 95% sequence identity hits
    if(gene == "pasA1" | gene == "pasA2"){
      list[[gene]] <- dplyr::filter(list[[gene]], pident >= 95)
    }
    #filter pasD1 and pasD2 dfs for >= 98% sequence identity hits
    if(gene == "pasD1" | gene == "pasS2"){
      list[[gene]] <- dplyr::filter(list[[gene]], pident >= 98)
    }
  }
  df <- bind_rows(list)
  return(df)
}
#running homolog filtering
millard_filtered <- pas_filter(millard_blast)

#-----adding Millard lab metadata to blast results-----#
millard_metadata <- read_tsv(file = "inputs/millard_20241106/metadata.tsv") %>%
  mutate(sseqid = factor(Accession), Accession = NULL)
#joining
millard_df_full <- millard_filtered %>%
  left_join(millard_metadata, by = "sseqid")
write.csv(x = millard_df_full, file = "outputs/millard_blast_filtered_full.csv")

#-----summarizing based on unique bacteriophage genomes-----#
millard_df_summarized <- millard_df_full %>%
  mutate(qseqid = factor(qseqid, levels = c("pasA1", "pasA2", "pasB", "pasC", "pasD1", "pasD2")), phage = factor(Description)) %>%
  #fill values are the nucleotide sequence identity for each hit in each respective genome
  #this would not work as cleanly if any genome had more than one hit for a given sRNA
  pivot_wider(id_cols = phage, names_from = qseqid, values_from = pident, values_fill = list(pident = 0))
write.csv(x = millard_df_summarized, file = "outputs/millard_blast_summarized.csv", row.names = F)