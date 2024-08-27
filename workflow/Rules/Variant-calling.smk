'''
This is the snakemake file to invoke and use Platypus for the variant calling.
'''


rule samtools_faidx:
    input:
        sample = f"{data_dir}/{ref_genome}{ref_genome_ext}"
    output:
        f"{results_dir}/{ref_genome}.fa.fai"
    log:
        stdout = f"{results_dir}/logs/indexing/{ref_genome}.log",
        stderr = f"{results_dir}/logs/indexing/{ref_genome}_err.log"
    message:
        "Indexing the used reference for the BAM mapping for the variant calling."
    shell:
        """
        samtools faidx --fai-idx {output} {input.sample} > {log.stdout} 2> {log.stderr}
        """

"""
Due to the fact that platypus couldn't be build using conda and the necessary packages,
this has been replaced by a different variant calling method.
"""

rule bcftools_mpileup:
    input:
        alignments = expand(f"{results_dir}/sorted/{{sample_name}}.sorted.bam", sample_name=sample_names),
        #ref = f"{data_dir}/{ref_genome}{ref_genome_ext}",  # this can be left out if --no-reference is in options
        index = f"{results_dir}/{ref_genome}.fa.fai"
    output:
        pileup=expand(f"{results_dir}/pileups/{{sample_name}}.pileup.vcf", sample_name=sample_names)
    message:
        "Calling variants using bcftools on the following BAM files: {input.alignments}"
    log:
        stdout = expand(f"{results_dir}/logs/bcftools_mpileup/{{sample_name}}.log", sample_name=sample_names),
        stderr = expand(f"{results_dir}/logs/bcftools_mpileup/{{sample_name}}_err.log", sample_name=sample_names)
    shell:
        """
        bcftools mpileup -o {output.pileup} -O z -f {input.index} {input.alignments} > {log.stdout} 2> {log.stderr}
        """

