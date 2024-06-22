

rule trim_and_cut:
    # Input needs to be the demultiplexed FastQ bestanden
    input:
        ""
    output:
        ""
    message: "Trimming and cutting files with CutAdapt"
    shell:
        "cutadapt "
