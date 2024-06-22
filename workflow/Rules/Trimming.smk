'''
This Snakefile is used to use CutAdapt and trim the fastQ files.
'''

rule trim_and_cut:
    # Input needs to be the demultiplexed FastQ bestanden
    input:
        ["reads/{sample}.1.fastq", "reads/{sample}.2.fastq"]
    output:
        fastq1="trimmed/{sample}.1.fastq",
        fastq2="trimmed/{sample}.2.fastq",
        qc="trimmed/{sample}.qc.txt"
    params:
        # https://cutadapt.readthedocs.io/en/stable/guide.html#adapter-types
        adapters="-a AGAGCACACGTCTGAACTCCAGTCAC -g AGATCGGAAGAGCACACGT -A AGAGCACACGTCTGAACTCCAGTCAC -G AGATCGGAAGAGCACACGT",
        # https://cutadapt.readthedocs.io/en/stable/guide.html#
        extra="--minimum-length 1 -q 20"
    log:
        "logs/cutadapt/{sample}.log"
    message:
        "Trimming and cutting files with CutAdapt"
    threads: 8
    wrapper:
        "v3.12.1/bio/cutadapt/pe"
