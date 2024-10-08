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
    return [f"{data_dir}/demultiplexed/{sample}_R{read}.fastq" for read in [1,2] for sample in get_sample_names_from_barcodes()]


rule sabre_demultiplex:
    input:
        forward_sample = f"{data_dir}/{sample_file_name}_R1.fastq",
        reverse_sample = f"{data_dir}/{sample_file_name}_R2.fastq"
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
        sabre pe -f {input.forward_sample} -r {input.reverse_sample} -b {barcodes} -u unknown_sample_R1.fastq -w unknown_sample_R2.fastq -c
        """
