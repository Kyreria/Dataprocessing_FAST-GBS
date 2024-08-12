'''
This is the snakemake file to invoke and use Platypus for the variant calling.
'''


rule samtools_faidx:
    input:
        sample = f"{data_dir}/{ref_genome}{ref_genome_ext}"
    output:
        f"{results_dir}/{ref_genome}.fa.fai"
    log:
        f"{results_dir}/logs/indexing/{ref_genome}.log"
    message: "Indexing the used reference for the BAM mapping for the variant calling."
    params:
        extra=""
    wrapper:
        "v3.12.2/bio/samtools/faidx"

"""
Due to the fact that platypus couldn't be build using conda and the necessary packages,
this has been replaced by a different variant calling method.
"""

rule bcftools_mpileup:
    input:
        alignments = f"{results_dir}/mapped/{sample_names}.bam",
        ref = f"{data_dir}/{ref_genome}{ref_genome_ext}",  # this can be left out if --no-reference is in options
        index = f"{results_dir}/{ref_genome}.fa.fai"
    output:
        pileup=f"{results_dir}/pileups/{sample_names}.pileup.vcf"
    params:
        uncompressed_bcf=False,
        extra="--max-depth 100 --min-BQ 15 --output-type z"
    message: "Calling variants using bcftools on the following BAM files: {input.alignments}"
    log:
        f"{results_dir}/logs/bcftools_mpileup/{sample_names}.log"
    wrapper:
        "v3.12.2/bio/bcftools/mpileup"

