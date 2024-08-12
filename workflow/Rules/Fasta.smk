'''
This Snakefile is to demultiplex the fasta files,
 so they can be used by the rest of the rules.
'''

# Due to the fact that demultiplexing is a very niche case, this has been disabled and simply replaced.
# It's been replaced by a rule to split a single paired ends sample file into a [sample]_r1 and [sample]_R2 file.

rule sabre_demultiplex:
    input:
        pass
    output:
        pass
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


