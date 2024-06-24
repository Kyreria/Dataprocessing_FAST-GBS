'''
This Snakefile is used to use CutAdapt and trim the fastQ files.
'''

rule trim_and_cut:
    # Input needs to be the demultiplexed FastQ bestanden
    input:
        [f"reads/{sample_name}.1.fastq", f"reads/{sample_name}.2.fastq"]
    output:
        fastq1=f"trimmed/{sample_name}.1.fastq",
        fastq2=f"trimmed/{sample_name}.2.fastq",
        qc=f"trimmed/{sample_name}.qc.txt"
    params:
        # https://cutadapt.readthedocs.io/en/stable/guide.html#adapter-types
        adapters="-a AGAGCACACGTCTGAACTCCAGTCAC -g AGATCGGAAGAGCACACGT -A AGAGCACACGTCTGAACTCCAGTCAC -G AGATCGGAAGAGCACACGT",
        # https://cutadapt.readthedocs.io/en/stable/guide.html#
        extra="--minimum-length 1 -q 20"
    log:
        f"logs/cutadapt/{sample_name}.log"
    message:
        "Trimming and cutting files with CutAdapt"
    threads: 8
    wrapper:
        "v3.12.1/bio/cutadapt/pe"
