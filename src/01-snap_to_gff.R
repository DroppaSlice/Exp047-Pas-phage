library(microseq)
library(stringr)
library(dplyr)

#-----Defining the function snap_to_gff-----#
snap_to_gff <- function(filepath, write = T, outfile, features = c("name", "position", "length", "strand", "type"), filter = TRUE, types = c("gene", "ncRNA")){
  
  #-----error handling messages to check input arguments-----#
  if(write == T & missing(outfile)){
    stop("Error: Must provide outfile if writing gff!")
  }
  
  if(!is.vector(features, mode = "character")){
    stop("Error: \'feature\' should be a character vector ")
  }
  
  if(length(features) > 5){
    stop("Error: \'feature'\ should not have length greater than 5")
  }
  
  #-----specify the data features exported from Snapgene-----#
  #by default this function expects that all 5 features are exported into tsv format
  col.names <- features
  
  #-----reading in snap feature table-----
  snap_table <- read.table(filepath) %>%
    rename_with(~col.names)
  
  if(filter == T){
    snap_table <- snap_table %>%
      filter(type %in% types)
  }
  
  #-----cleaning snapgene data-----#
  start_v <- as.numeric(str_extract(str_remove_all(snap_table$position, ","), "^\\d+"))
  end_v <- start_v + as.numeric(str_remove_all(snap_table$length, ",")) - 1
  strand_v <- if_else(snap_table$strand == "=>", "+", "-")
  attributes_v <- paste0("ID=", snap_table$name)
  
  #-----constructing GFF data frame to match structure of standard GFF-----#
  gff_table <- tibble(
    Seqid = snap_table$name,
    source = "Snapgene",
    type = "gene", 
    start = start_v,
    end = end_v,
    score = ".",
    strand = strand_v,
    phase = 0,
    attributes = attributes_v
  )
  
  #-----writing gff file-----#
  if(write == T & !missing(outfile)){
    writeGFF(gff.table = gff_table, out.file = outfile)
  }
}

#-----setting up test examples-----#
pathname <- "inputs/prophages/"
files <- list.files(path = "inputs/prophages/", pattern = "*.txt")

#-----run snap_to_gff() using a loop through the specified files-----#
for(file in files){
  filepath_ <- paste0(pathname, file)
  outfile_ <- paste0("outputs/", str_remove(file, ".txt"), ".gff3")
  
  snap_to_gff(filepath = filepath_, outfile = outfile_)
}