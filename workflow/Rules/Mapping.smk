'''
This snakefile is to align and map the reads,
 so they can be used for variant calling.
'''


rule bwa_mem:
    input:
        R1 = expand(f"{results_dir}/trimmed/{{sample_name}}_R1.fastq", sample_name=sample_names),
        R2 = expand(f"{results_dir}/trimmed/{{sample_name}}_R2.fastq", sample_name=sample_names),
        idx=f"{data_dir}/{ref_genome}{ref_genome_ext}",
        flag=f"{results_dir}/flag/genome_indexed"
    output:
        expand(f"{results_dir}/mapped/{{sample_name}}.bam", sample_name=sample_names)
    log:
        stdout = expand(f"{results_dir}/logs/bwa_mem/{{sample_name}}.log", sample_name=sample_names),
        stderr = expand(f"{results_dir}/logs/bwa_mem/{{sample_name}}_err.log", sample_name=sample_names)
    shell:
        """
        bwa mem {input.idx} {input.R1} {input.R2} | samtools sort -o {output}
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
        bwa index {input.genome} && touch {output}
        """
