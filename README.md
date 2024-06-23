# Dataprocessing_FAST-GBS
Dataprocessing project for converting the FAST-GBS pipeline to a snakemake pipeline.
This is the final assigment for the Data Processing course from the Bioinformatics bachelor program of the Hanze University of Applied Scieces.

The pipeline performs the following steps:

1. Demultiplexing raw sequencing reads using Sabre.
2. Adapter trimming with CutAdapt
3. Read mapping with BWA-MEM
4. Variant calling with Platypus
5. Visualization of the VCF file with an R-script.

## Prerequisites
To run this pipeline, you will need the following software installed.

- [Conda](https://conda.io/projects/conda/en/latest/user-guide/getting-started.html)
- [Snakemake](https://snakemake.readthedocs.io/en/stable/)


## Installation

1. Clone this repository

```
git clone https://github.com/Kyreria/Dataprocessing_FAST-GBS
cd Dataprocessing_FAST-GBS
```

2. 
Due to the fact that we need multiple conda enviroments to run this Snakemake pipeline, I advise you to do the following.

Make a conda environment for the main tools, this being cutadapt and BWA.
Then we need a second conda environment for python 2.7, this is due to the fact that platypus hasn't been updated out of python 2.7.
(insert detailed instructions here later, but it needs to involve the following:

``
conda create -n nanofilt -c bioconda nanofilt
conda activate nanofilt
conda env export > env/nanofilt.yaml
``

We also need to see about removing the prefix line in said yaml file, hopefully that won't be too much of a hassle.
So yeah, fun times.

## Configuration

The pipeline is configured with the `config/config.yml` file.
Please use this file to adjust any necessary settings.

- `data_dir`: Path to the directory for the input data.
- `results_dir`: Path to the directory where results will be stored.
- `ref_genome`: genome file name, which must be in the `data_dir`.
- `barcode_file`: Barcode file name, which must also be in `data_dir`.
- `read_name`:
- `type_of_sequence`: The type of sequence, this can be either single or paired.
- `adaptor_sequence`: The adaptor sequence, this is for CutAdapt
- `output_file_name`: This is for the final output

## Running the pipeline
With the correct conda environment activated, done with the following command, if you hadn't done so yet:

```conda activate dataprocessing```

We can run the snakemake pipeline using the following command:

```snakemake --cores <number_of_cores>```

You can replace `<number_of_cores>` with the desired number of CPU cores you wish to use.

## Output

This pipeline will generate the following output files in your `results_dir`.
- Demultiplexed FASTQ files
- Trimmed FASTQ files
- Mapped BAM Files
- Variants VCF File
- An R Plot with the variants

## Visualisation of the pipeline using Directed Acyclic Graph (DAG)

To visualize the pipeline, please use the following command:

```snakemake --dag | dot -Tsvg > dag.svg```

This will generate an SVG file called `dag.svg` which can be viewed in an image viewer or on a web browser.

The image is also included below if you do not wish to run the command yourself.