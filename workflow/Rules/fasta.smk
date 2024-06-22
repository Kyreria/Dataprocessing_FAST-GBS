'''
This Snakefile is to demultiplex the fasta files,
 so they can be used by the rest of the rules.
'''

rule demultiplex:
    # Input needs to be barcode file & fastQ bestanden
    input:
        barcodes="",
        fastQ=""
    output:
        "results/demultiplexed/{wildcard}.fastq"
    message: "Demultiplexing {input.fastQ} using SABRE."
    shell:
        "sabre se -f {input.fastQ} -b {input.barcodes} -u unknown_barcode.fastq > {output}"
