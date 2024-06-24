'''
This is the snakemake file to plot the variant data in a plot.
'''

rule plot_variants:
    input:
        vcf_file="results/variants.vcf"
    output:
        plot_file="results/variants_scatterplot.png"
    log:
        "logs/plot_variants.log"
    message:
        "Plotting the variants now!"
    shell:
        """
        Rscript scripts/plot_variants.R {input.vcf_file} {output.plot_file} > {log} 2>&1
        """
