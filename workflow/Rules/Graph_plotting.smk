'''
This is the snakemake file to plot the variant data in a plot.
'''

rule plot_variants:
    input:
        vcf_file=f"{results_dir}/pileups/{sample_name}.pileup.vcf"
    output:
        plot_file=f"{results_dir}/variants_scatterplot.png"
    log:
        f"{results_dir}/logs/plot_variants.log"
    message:
        "Plotting the variants now!"
    shell:
        """
        Rscript Scripts/plot_variants.R {input.vcf_file} {output.plot_file} > {log} 2>&1
        """
