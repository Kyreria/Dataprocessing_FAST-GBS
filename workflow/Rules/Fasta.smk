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
    run:
        # Make the first output file
        output_r1 = output.R1
        with open(output_r1, 'w') as R1:
            pass
        # Make the second output file
        output_r2 = output.R2
        with open(output_r2, 'w') as R2:
            pass
        #Loop through the single file with paired ends and split them into their respective files.
        with open(input.fastq_file, "r") as input:
            counter=0
            R2_flag= False
            for line in input:
                match R2_flag:
                    case False:
                        with open(output_r1, 'a') as r1:
                            r1.write(line)
                        counter+= 1
                        if counter == 4:
                            counter = 0
                            R2_flag = True
                    case True:
                        with open(output_r2, 'a') as r2:
                            r2.write(line)
                        counter+= 1
                        if counter == 4:
                            counter = 0
                            R2_flag = False
        print("File mangling is done.")

