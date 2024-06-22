

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
