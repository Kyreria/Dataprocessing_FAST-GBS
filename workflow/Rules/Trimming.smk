'''
This Snakefile is used to use CutAdapt and trim the fastQ files.
'''

rule trim_and_cut:
    # Input needs to be the demultiplexed FastQ bestanden
    input:
        forward_reads= expand(f"{data_dir}/demultiplexed/{{sample_name}}_R1.fastq", sample_name=sample_names),
        reverse_reads= expand(f"{data_dir}/demultiplexed/{{sample_name}}_R2.fastq", sample_name=sample_names)
    output:
        fastq1= expand(f"{results_dir}/trimmed/{{sample_name}}_R1.fastq", sample_name=sample_names),
        fastq2= expand(f"{results_dir}/trimmed/{{sample_name}}_R2.fastq", sample_name=sample_names),
        # qc= expand(f"{results_dir}/trimmed/{{sample_name}}.qc.txt", sample_name=sample_names)
    params:
        # https://cutadapt.readthedocs.io/en/stable/guide.html#adapter-types
        adapters="-a AGAGCACACGTCTGAACTCCAGTCAC -g AGATCGGAAGAGCACACGT -A AGAGCACACGTCTGAACTCCAGTCAC -G AGATCGGAAGAGCACACGT",
        # https://cutadapt.readthedocs.io/en/stable/guide.html#
        extra="--minimum-length 1 -q 20"
    # log:
        # stdout= expand(f"{results_dir}/logs/cutadapt/{{sample_name}}.log", sample_name=sample_names),
        # stderr= expand(f"{results_dir}/logs/cutadapt/{{sample_name}}_err.log", sample_name=sample_names)
    message:
        "Trimming and cutting files with CutAdapt"
    shell:
        """
        cutadapt {params.adapters} -o {output.fastq1} -p {output.fastq2} 
        {input.forward_reads} {input.reverse_reads}
        """
