'''
This is the snakemake file to invoke and use Platypus for the variant calling.
'''

rule reference_index:
    input:
        ""
    output:
        "results/reference/"
    message: "Indexing the used reference for the BAM mapping for the Platypus variant calling."

rule platypus_variant_calling:
    # This needs to open up a different conda enviroment that's running in python 2.7
    input:
        reference=f"{data_dir}/{ref_genome}",
        bamfiles=""
    output:
        "results/variants.vcf"
    message: "Calling variants using Platypus on the following BAM files: {bamfiles}"
    log:
        "logs/platypus.log"
    shell:
        "python Platypus.py callVariants --bamFiles {input.bamfiles} --refFile {input.reference}"
        " --output {output}"
        "--logFileName platypus.log"
