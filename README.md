# Dataprocessing_FAST-GBS
Dataprocessing project for converting the FAST-GBS pipeline to a snakemake pipeline.

## Installation

Due to the fact that we need multiple conda enviroments to run this Snakemake pipeline, I advise you to do the following.

Make a conda environment for the main tools, this being cutadapt and BWA.
Then we need a second conda environment for python 2.7, this is due to the fact that platypus hasn't been updated out of python 2.7.
(insert detailed instructions here later, but it needs to involve the following:
``
conda create -n nanofilt -c bioconda nanofilt
conda activate nanofilt
conda env export > env/nanofilt.yaml
``)

We also need to see about removing the prefix line in said yaml file, hopefully that won't be too much of a hassle.

So yeah, fun times.