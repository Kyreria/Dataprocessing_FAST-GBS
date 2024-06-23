'''
This Snakefile is to demultiplex the fasta files,
 so they can be used by the rest of the rules.
'''

# Function needed to get the correct output files, otherwise demultiplexing fails.
def get_demultiplex_output_files():
    return [f"{results_dir}/demultiplexed/{sample}_R{read}.fastq" for read in [1, 2] for sample in get_sample_names()]

rule demultiplex:
    # Input needs to be barcode file & fastQ bestanden
    input:
        R1 = f"{data_dir}/{read_name}_R1.fastq",
        R2= f"{data_dir}/{read_name}_R2.fastq",
        barcodes=f"{data_dir}/{barcodes}"
    output:
        demultiplex_flag = touch("results/flags/demultiplexed_done"),
        output_files = get_demultiplex_output_files()
    message:
        "Demultiplexing {input.fastQ} using SABRE."
    log:
        f"logs/demultiplex/{read.name}.log"
    params:
        output_dir = f"{results_dir}/demultiplexed"
    shell:
        """
        (
        mkdir -p {params.output_dir}
        cd {params.output_dir}
        sabre se -f {input.R1} -r {input.R2} -b {input.barcodes} -u unknown_sample_R1.fastq - w unkown_sample_R2.fastq -c
        ) > {log} 2>&1
        """
