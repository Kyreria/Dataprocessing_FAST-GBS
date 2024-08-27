'''
This snakefile is to sort the reads.
'''


rule samtools_sort:
    input:
        expand(f"{results_dir}/mapped/{{sample_name}}.bam", sample_name=sample_names)
    output:
        expand(f"{results_dir}/sorted/{{sample_name}}.sorted.bam", sample_name=sample_names)
    log:
        stdout = expand(f"{results_dir}/logs/samtools/{{sample_name}}.log", sample_name=sample_names),
        stderr = expand(f"{results_dir}/logs/samtools/{{sample_name}}_err.log", sample_name=sample_names)
    shell:
        """
        samtools sort -o {output} {input}
        """