'''
This snakefile is to align and map the reads,
 so they can be used for variant calling.
'''


rule bwa_mem:
    input:
        R1 = f"{results_dir}/trimmed/{sample_names}_R1.fastq",
        R2 = f"{results_dir}/trimmed/{sample_names}_R2.fastq",
        idx=f"{data_dir}/{ref_genome}{ref_genome_ext}",
        flag=f"{results_dir}/flag/genome_indexed"
    output:
        f"{results_dir}/mapped/{sample_names}.bam"
    log:
        stdout = f"{results_dir}/logs/bwa_mem/{sample_names}.log",
        stderr = f"{results_dir}/logs/bwa_mem/{sample_names}_err.log"
    shell:
        """
        bwa mem -t 2 {input.idx} {input.R1} {input.R2} | samtools view -bS > {log.stdout} 2> {log.stderr}
        """



rule bwa_index:
    input:
        genome = f"{data_dir}/{ref_genome}{ref_genome_ext}"
    output:
        index = touch(f"{results_dir}/flag/genome_indexed")
    log:
        stdout = f"{results_dir}/logs/bwa_index.log",
        stderr = f"{results_dir}/logs/bwa_index_error.log"
    shell:
        """
        bwa index {input.genome} && touch {output} > {log.stdout} 2> {log.stderr}
        """
