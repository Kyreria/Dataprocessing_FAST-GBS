
# Get command line arguments
args <- commandArgs(trailingOnly = TRUE)
vcf_file <- args[1]
output <- args[2]

# Read the VCF data
data <- read.table(vcf_file, header= FALSE, comment.char= "#", stringsAsFactors = FALSE)

#Since colnames aren't available, use VCF format.
colnames(data) <- c("CHROM", "POS", "ID", "REF", "ALT", "QUAL", "FILTER", "INFO")
