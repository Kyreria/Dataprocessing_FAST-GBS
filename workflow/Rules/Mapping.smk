'''
This snakefile is to align and map the reads,
 so they can be used for variant calling.
'''

rule bwa_mem:
    input:
        reads=["reads/{sample}.1.fastq", "reads/{sample}.2.fastq"],
        idx=multiext("genome", ".amb", ".ann", ".bwt", ".pac", ".sa")
    output:
        "mapped/{sample}.bam"
    log:
        "logs/bwa_mem/{sample}.log"
    params:
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
        sorting="none",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="queryname",  # Can be 'queryname' or 'coordinate'.
        sort_extra=""  # Extra args for samtools/picard.
    threads: 8
    wrapper:
        "v3.12.1/bio/bwa/mem"

rule bwa_index:
    input:
        ""
    output:
        ""
    message: "Indexing the BAM files for the Platypus mapping."
