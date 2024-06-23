'''
This snakefile is to align and map the reads,
 so they can be used for variant calling.
'''

rule bwa_mem:
    input:
        reads=["reads/{sample}_R1.fastq", "reads/{sample}_R2.fastq"],
        idx=multiext("genome", ".amb", ".ann", ".bwt", ".pac", ".sa")
    output:
        "results/mapped/{sample}.bam"
    log:
        "logs/bwa_mem/{sample}.log"
    params:
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
        sorting="samtools",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="queryname",  # Can be 'queryname' or 'coordinate'.
        sort_extra=""  # Extra args for samtools/picard.
    threads: 2
    wrapper:
        "v3.12.1/bio/bwa/mem"

rule bwa_index:
    input:
        genome = f"{data_dir}/{ref_genome}"
    output:
        index = touch("results/flag/genome_indexed")
    message: "Indexing the BAM files for the Platypus mapping."
    log:
        "logs/bwa_index.log"
    shell:
        """
        ( if [ "$(ls {data_dir} | grep "{genome}" | wc -1)" - lt 6]; then
            bwa index {input.genome}
        fi
        ) > {log} 2>&1
        """
