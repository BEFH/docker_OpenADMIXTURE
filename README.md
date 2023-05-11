# OpenADMIXTURE docker container

This is a repo that contains the code for a docker container with OpenADMIXTURE.

The original repository can be found [here.](https://github.com/OpenMendel/OpenADMIXTURE.jl)

## Installation

To install the container, run the following using docker:

```bash
docker pull befh/openadmxture
```

or the following with singularity:

```bash
singularity pull --name bcftools.img docker://befh/openadmixture:latest
```

To use with Snakemake, you do not need to install. Just put the following in the Snakefile:

```snakemake
container: 'docker://befh/openadmixture:latest'
```

Then run with `snakemake --use-singularity` see https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html for more info.

## Usage

To run with docker, `docker run openadmixture [ARGS]`.

To run with singularity, `singularity run openadmixture.img [ARGS]`.

To access tools other than openadmixture, open a shell.
