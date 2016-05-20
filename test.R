library("sleuth")

base_dir <- "/home/user/test/cuffdiff2_data_kallisto_results"
sample_id <- dir(file.path(base_dir,"results"))
print(sample_id)
kal_dirs <- sapply(sample_id, function(id) file.path(base_dir, "results", id, "kallisto"))
print(kal_dirs)

s2c <- read.table(file.path(base_dir, "hiseq_info.txt"), header = TRUE, stringsAsFactors=FALSE)
s2c <- dplyr::select(s2c, sample = run_accession, condition)
print(s2c)
s2c <- dplyr::mutate(s2c, path = kal_dirs)
print(s2c)

so <- sleuth_prep(s2c, ~ condition)
so <- sleuth_fit(so)
so <- sleuth_wt(so, 'conditionscramble')

#source("http://bioconductor.org/biocLite.R")
#biocLite("biomaRt")
#mart <- biomaRt::useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
#t2g <- biomaRt::getBM(attributes = c("ensembl_transcript_id", "ensembl_gene_id", "external_gene_name"), mart = mart)
#t2g <- dplyr::rename(t2g, target_id = ensembl_transcript_id, ens_gene = ensembl_gene_id, ext_gene = external_gene_name)
#so <- sleuth_prep(s2c, ~ condition, target_mapping = t2g)

#so <- sleuth_fit(so)
#so <- sleuth_wt(so, which_beta = 'conditionscramble')
#sleuth_live(so)

results_table <- sleuth_results(so, 'conditionscramble')

print(results_table)