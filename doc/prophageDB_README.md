# Prophage-DB: A comprehensive database to explore diversity, distribution, and ecology of prophages

[https://doi.org/10.5061/dryad.3n5tb2rs5](https://doi.org/10.5061/dryad.3n5tb2rs5)

This dataset contains prophage sequences (available as .fna files) identified from prokaryotic genomes from three public databases (Genome Taxonomy Database (GTDB) (release 207), National Center for Biotechnology Information (NCBI) Reference Sequence (RefSeq) database (accessed March 2023), and Searchable Planetary-scale mIcrobiome REsource (SPIRE). The downloaded prokaryotic genomes from these databases contained both archaeal and bacterial representative genomes (SPIRE also included data from unknown hosts). 

## Methods

Prophage identification from downloaded representative genomes was carried out using VIBRANT (v1.2.1). We used the default arguments when using VIBRANT (minimum scaffold length requirement = 1000 base pairs, minimum number of open readings frames (ORFs, or proteins) per scaffold requirement = 4). The identified prophages are provided in .fna format within three .tar.gz files listed in the next section.  

We used skani (v0.2.1) to perform virus clustering. Identified prophages (i.e. VIBRANT output nucleotide files for phages), were used as input. We performed all-to-all comparisons using the skani default arguments, except for the alignment fraction argument which was set to 85 (--min-af 85). After obtaining ANI and alignment fraction, we removed viral sequences for which ANI was 100 and both the query and subject had at least 85 alignment fractions. 

Taxonomic assignment of viral sequences was carried out using  geNomad (v1.7.0). Taxonomic assignment was carried out with the annotate module. In addition, we utilized CheckV (v1.0.1) to assess viral quality, completeness, and contamination.

## Description of the data and file structure

Prophage-DB contains a total of 356,776 prophage sequences (323,608 sequences from bacterial hosts, 21,226 sequences from unknown hosts, and 11,942 from archaeal hosts). These sequences are available in three different files corresponding to each host group (archaeal_host_prophages.tar.gz, bacterial_host_prophages.tar.gz, unknown_host_prophages.tar.gz), in addition the proteins are found in a separate (file prophage_proteins.faa.gz). The metadata file (metadata.xlsx) contains the collected metadata from GTDB and SPIRE, in addition it includes geNomad, CheckV results, and auxiliary metabolic gene information. The description of each column is found in the medatadata file. Data that appears as NA was not available in the original metadata files or was not obtained by the used software.

This database contains four compressed files (.tar.gz or .gz format):

archaeal_host_prophages.tar.gz, bacterial_host_prophages.tar.gz, unknown_host_prophages.tar.gz, and prophage_proteins.faa.gz

To open these files use the following commands in Unix-based systems and Windows (10 or later):

* tar -xzf archaeal_host_prophages.tar.gz
* tar -xzf bacterial_host_prophages.tar.gz
* tar -xzf unknown_host_prophages.tar.gz
* gunzip prophage_proteins.faa.gz

Once extracted, the .tar.gz files will contain .fna files, which are FASTA files containing the prophage nucleotide sequences. The file  prophage_proteins.faa contains the proteins of all prophage sequences. 

To view the files you can use pre-installed text editors such as nano, vim, TextEdit or Notepad (Windows). Example:

* nano filename.fna
* notepad filename.fna

## Access information

Prokaryte genomes were obtained from the following sources:

* GTDB: [https://data.gtdb.ecogenomic.org/releases/release207/207.0/](https://data.gtdb.ecogenomic.org/releases/release207/207.0/)
* NCBI RefSeq: [https://www.ncbi.nlm.nih.gov/genome/browse#!/prokaryotes/ ](https://www.ncbi.nlm.nih.gov/genome/browse#!/prokaryotes/)(filter by representative and bacteria/archaea)
* SPIRE: [spire.embl.de](https://spire.embl.de/) Publication: Schmidt, T. S. B. *et al.* SPIRE: a Searchable, Planetary-scale mIcrobiome REsource. *Nucleic Acids Res.* **52**, D777–D783 (2024).

## Software used in our study

Publication: Kieft, K., Zhou, Z. & Anantharaman, K. VIBRANT: automated recovery, annotation and curation of microbial viruses, and evaluation of viral community function from genomic sequences. *Microbiome* **8**, 90 (2020). Link to software: [https://github.com/AnantharamanLab/VIBRANT](https://github.com/AnantharamanLab/VIBRANT)

Publication: Skani enables accurate and efficient genome comparison for modern metagenomic datasets. *Nat. Methods* **20**, 1633–1634 (2023). Link to software: [https://github.com/bluenote-1577/skani](https://github.com/bluenote-1577/skani)

Publication: Camargo, A. P. *et al.* Identification of mobile genetic elements with geNomad. *Nat. Biotechnol.* 1–10 (2023) doi:10.1038/s41587-023-01953-y. Link to software: [https://github.com/apcamargo/genomad](https://github.com/apcamargo/genomad)

Publication: Nayfach, S. *et al.* CheckV assesses the quality and completeness of metagenome-assembled viral genomes. *Nat. Biotechnol.* **39**, 578–585 (2021). Link to software: [https://bitbucket.org/berkeleylab/checkv/src/master/](https://bitbucket.org/berkeleylab/checkv/src/master/)
