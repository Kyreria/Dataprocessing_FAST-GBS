'''
This is the snakemake file to plot the variant data in a plot.
'''

rule plot_variants:
    input:
        vcf_file= expand(f"{results_dir}/pileups/{{sample_name}}.pileup.vcf", sample_name=sample_names)
    output:
        plot_file=f"{results_dir}/variants.png"
    log:
        stdout=f"{results_dir}/logs/plot_variants.log",
        stderr=f"{results_dir}/logs/plot_variants_error.log"

    message:
        "Plotting the variants now!"
    shell:
        """
        Rscript Scripts/plot_variants.R {input.vcf_file} {output.plot_file}
        """
