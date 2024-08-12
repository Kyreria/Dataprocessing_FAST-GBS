# Get the packages needed for visualisation.
if (!require("devtools")) install.packages("devtools")
if (!require("BiocManager")) install.packages("BiocManager")
remotes::install_github(
    "cccnrc/plot-VCF",
    repos = BiocManager::repositories()
)

library(plotVCF)

# Get command line arguments
args <- commandArgs(trailingOnly = TRUE)
vcf_file <- args[1]
output <- args[2]

# Read the VCF data
data <- read.table(vcf_file, header= FALSE, comment.char= "#", stringsAsFactors = FALSE)

#Since colnames aren't available, use VCF format.
colnames(data) <- c("CHROM", "POS", "ID", "REF", "ALT", "QUAL", "FILTER", "INFO")

# Making use of the new "package, plotVCF
VCF_Plot <- createVCFplot(vcf_file, ORDERED=TRUE)
PNG_File <- output

png(PNG_File, width=5000, height=2500, res=300)
print(VCF_Plot)
dev.off()