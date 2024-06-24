'''
This Snakefile is to demultiplex the fasta files,
 so they can be used by the rest of the rules.
'''

# Due to the fact that demultiplexing is a very niche case, this has been disabled and simply replaced.
# It's been replaced by a rule to split a single paired ends sample file into a [sample]_r1 and [sample]_R2 file.

# Function needed to get the correct output files, otherwise demultiplexing fails.
# def get_demultiplex_output_files():
#     return [f"{results_dir}/demultiplexed/{sample}_R{read}.fastq" for read in [1, 2] for sample in get_sample_names()]

# get_sample_namesrule demultiplex:
#     # Input needs to be barcode file & fastQ bestanden
#     input:
#         R1 = f"{data_dir}/{read_name}_R1.fastq",
#         R2= f"{data_dir}/{read_name}_R2.fastq",
#         barcodes=f"{data_dir}/{barcodes}"
#     output:
#         demultiplex_flag = touch("results/flags/demultiplexed_done"),
#         output_files = get_demultiplex_output_files()
#     message:
#         "Demultiplexing {input.fastQ} using SABRE."
#     log:
#         f"logs/demultiplex/{read.name}.log"
#     params:
#         output_dir = f"{results_dir}/demultiplexed"
#     shell:
#         """
#         (
#         mkdir -p {params.output_dir}
#         cd {params.output_dir}
#         sabre se -f {input.R1} -r {input.R2} -b {input.barcodes} -u unknown_sample_R1.fastq - w unkown_sample_R2.fastq -c
#         ) > {log} 2>&1
#         """

rule seperate_paired_reads:
    input:
        fastq_file = f"{data_dir}/{fastq_name}.fastq"
    output:
        R1 = f"{data_dir}/seperated/{fastq_file}_R1.fastq",
        R2 = f"{data_dir}/seperated/{fastq_file}_R2.fast"
    message:
        "Splitting paired end reads from a single file into 2 seperate files."
    run:
        # Make the first output file
        output_r1 = output.R1
        with open(output_r1, 'w') as R1:
            pass
        # Make the second output file
        output_r2 = output.R2
        #Loop through the single file with paired ends and split them into their respective files.
        with open(input.fastq_file, "r") as input:
            counter=0
            R2_flag= False
            for line in input:
                match R2_flag:
                    case False:
                        with open(output_r1, 'a') as r1:
                            r1.write(line)
                        counter+=1
                        if counter==4:
                            counter=0
                            R2_flag =True
                    case True:
                        with open(output_r2, 'a') as r2:
                            r2.write(line)
                        counter+=1
                        if counter== 4:
                            counter = 0
                            R2_flag = False
        print("File mangling is done.")

