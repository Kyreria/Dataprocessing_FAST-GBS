'''
This snakefile is to sort the reads.
'''


rule samtools_sort:
    input:
        f"{results_dir}/mapped/{sample_names}.bam"
    output:
        f"{results_dir}/sorted/{sample_names}_sorted.bam"
    log:
        stdout = f"{results_dir}/logs/samtools/{sample_names}.log",
        stderr = f"{results_dir}/logs/samtools/{sample_names}_err.log"
    shell:
        """
        samtools sort -o {output} {input} > {log.stdout} 2> {log.stderr}
        """