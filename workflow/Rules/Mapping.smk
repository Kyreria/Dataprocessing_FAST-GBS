'''
This snakefile is to align and map the reads,
 so they can be used for variant calling.
'''

rule bwa_mem:
    input:
        reads=[f"{results_dir}/trimmed/{sample_name}_R1.fastq", f"{results_dir}/trimmed/{sample_name}_R2.fastq"],
        idx=f"{data_dir}/{ref_genome}{ref_genome_ext}"
    output:
        f"{results_dir}/mapped/{sample_name}.bam"
    log:
        f"{results_dir}/logs/bwa_mem/{sample_name}.log"
    params:
        extra="",
        sorting="samtools",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="queryname",  # Can be 'queryname' or 'coordinate'.
        sort_extra=""  # Extra args for samtools/picard.
    threads: 2
    wrapper:
        "v3.12.1/bio/bwa/mem"

rule bwa_index:
    input:
        genome = f"{data_dir}/{ref_genome}{ref_genome_ext}"
    output:
        index = touch(f"{results_dir}/flag/genome_indexed")
    message: "Indexing the reference genome for bwa mem mapping."
    log:
        f"{results_dir}/logs/bwa_index.log"
    shell:
        """(
        bwa index {input.genome} && touch {output}
        ) > {log} 2>&1
        """
