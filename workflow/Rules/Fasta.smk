'''
This Snakefile is to demultiplex the fasta files,
 so they can be used by the rest of the rules.
'''



def get_new_demultiplex_file_names():
    """
    List comprehension to get the sample names from the new barcodes file.
    This'll output the full pathing so that the Snakemake rule structure can continue.
    :return:
    """
    return [f"{results_dir}/demultiplexed/{sample}_R{read}.fastq" for read in [1,2] for sample in get_sample_names_from_barcodes()]


rule sabre_demultiplex:
    input:
        forward = f"{data_dir}/{sample_name}_R1.fastq",
        reverse = f"{data_dir}/{sample_name}_R2.fastq"
    output:
        output_files = get_new_demultiplex_file_names()
    log:
        stdout=f"{results_dir}/logs/sabre_demultiplex.log",
        stderr=f"{results_dir}/logs/sabre_demultiplex_error.log"
    message:
        "Demultiplexing the files using SABRE."
    params:
        output_dir = f"{results_dir}/demultiplexed"
    shell:
        """
        (
        mkdir -p {params.output_dir}
        cd {params.output_dir}
        sabre -pe -f {input.forward} -r {input.reverse} -b {barcodes} -u unknown_sample_R1.fastq
         -w unknown_sample_R2.fastq > {log.stdout} 2> {log.stderr}
         )
        """
