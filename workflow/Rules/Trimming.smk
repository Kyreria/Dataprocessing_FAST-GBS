'''
This Snakefile is used to use CutAdapt and trim the fastQ files.
'''

rule trim_and_cut:
    # Input needs to be the demultiplexed FastQ bestanden
    input:
        forward_reads= f"{data_dir}/demultiplexed/{{sample_name}}_R1.fastq",
        reverse_reads= f"{data_dir}/demultiplexed/{{sample_name}}_R2.fastq"
    output:
        fastq1= f"{results_dir}/trimmed/{{sample_name}}_R1.fastq",
        fastq2= f"{results_dir}/trimmed/{{sample_name}}_R2.fastq",
        qc= f"{results_dir}/trimmed/{{sample_name}}.qc.txt"
    params:
        # https://cutadapt.readthedocs.io/en/stable/guide.html#adapter-types
        adapters="-a AGAGCACACGTCTGAACTCCAGTCAC -g AGATCGGAAGAGCACACGT -A AGAGCACACGTCTGAACTCCAGTCAC -G AGATCGGAAGAGCACACGT",
        # https://cutadapt.readthedocs.io/en/stable/guide.html#
        extra="--minimum-length 1 -q 20"
    log:
        stdout= f"{results_dir}/logs/cutadapt/{{sample_name}}.log",
        stderr= f"{results_dir}/logs/cutadapt/{{sample_name}}_err.log"
    message:
        "Trimming and cutting files with CutAdapt"
    shell:
        """
        cutadapt {params.adapters} -o {output.fastq1} -p {output.fastq2} 
        {input.forward_reads} {input.reverse_reads} > {log.stdout} 2> {log.stderr}
        """
