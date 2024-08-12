'''
This Snakefile is to demultiplex the fasta files,
 so they can be used by the rest of the rules.
'''


rule sabre_demultiplex:
    input:
        forward = f"{data_dir}/seperated/{sample_name}_R1.fastq",
        reverse = f"{data_dir}/seperated/{sample_name}_R2.fastq"
    output:
        unknown_1 = f"{data_dir}/demultiplexed/unknown_forward.fastq",
        unknown_2 = f"{data_dir}/demultiplexed/unknown_reverse.fastq"
    log:
        stdout=f"{results_dir}/logs/sabre_demultiplex.log",
        stderr=f"{results_dir}/logs/sabre_demultiplex_error.log"
    message:
        "Demultiplexing the files "
    shell:
        """
        sabre -pe -f {input.forward} -r {input.reverse} -b {barcodes} -u {output.unknown_1}
         -w {output.unknown_2} > {log.stdout} 2> {log.stderr}
        """


rule seperate_paired_reads:
    input:
        fastq_file = f"{data_dir}/{sample_name}.fastq"
    output:
        R1 = f"{data_dir}/seperated/{sample_name}_R1.fastq",
        R2 = f"{data_dir}/seperated/{sample_name}_R2.fastq"
    message:
        "Splitting paired end reads from a single file into 2 seperate files."
    shell:
        """
        python Scripts/Read_seperator.py -i {input} -o {output}
        """


