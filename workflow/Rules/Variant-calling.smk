'''
This is the snakemake file to invoke and use Platypus for the variant calling.
'''


rule samtools_faidx:
    input:
        sample = f"{data_dir}/{ref_genome}{ref_genome_ext}"
    output:
        f"results/{ref_genome}.fa.fai"
    log:
        f"logs/indexing/{ref_genome}.log"
    message: "Indexing the used reference for the BAM mapping for the variant calling."
    params:
        extra=""
    wrapper:
        "v3.12.2/bio/samtools/faidx"

"""
Due to the fact that platypus couldn't be build using conda and the necessary packages,
this has been replaced by a different variant calling method.
The code for platypus is however still commented.
"""

rule bcftools_mpileup:
    input:
        alignments = f"mapped/{sample_name}.bam",
        ref = f"{data_dir}/{ref_genome}{ref_genome_ext}",  # this can be left out if --no-reference is in options
        index = f"{ref_genome}.fa.fai"
    output:
        pileup=f"pileups/{sample_name}.pileup.vcf"
    params:
        uncompressed_bcf=False,
        extra="--max-depth 100 --min-BQ 15 --output-type z"
    message: "Calling variants using bcftools on the following BAM files: {input.alignments}"
    log:
        f"logs/bcftools_mpileup/{sample_name}.log"
    wrapper:
        "v3.12.2/bio/bcftools/mpileup"


# rule platypus_variant_calling:
#     # This needs to open up a different conda enviroment that's running in python 2.7
#     input:
#         reference=f"{data_dir}/{ref_genome}",
#         bamfiles=""
#     output:
#         "results/variants.vcf"
#     message: "Calling variants using Platypus on the following BAM files: {bamfiles}"
#     log:
#         "logs/platypus.log"
#     shell:
#         "python Platypus.py callVariants --bamFiles {input.bamfiles} --refFile {input.reference}"
#         " --output {output}"
#         "--logFileName platypus.log"


