'''
This snakefile is to align and map the reads,
 so they can be used for variant calling.
'''

rule alignment:
    input:
        ""
    output:
        ""
    message: "Be"

rule samtool_index:
    input:
        ""
    output:
        ""
    message: "Indexing the BAM files for the Platypus mapping."