'''
This snakefile is to sort the reads.
'''


rule samtools_sort:
    input:
        f"{results_dir}/mapped/{{sample_name}}.bam"
    output:
        f"{results_dir}/sorted/{{sample_name}}.sorted.bam"
    log:
        stdout = f"{results_dir}/logs/samtools/{{sample_name}}.log",
        stderr = f"{results_dir}/logs/samtools/{{sample_name}}_err.log"
    shell:
        """
        (samtools sort {input} -o {output} ) > {log.stdout} 2> {log.stderr}
        """