This repository provides a conda environment definition
to install the R version of 'PEER' (see [here](https://github.com/PMBio/peer) for details on PEER) alongside
'tidyverse' and a simple R PEER wrapper script.

> UPDATE: We also provide a [Dockerfile](./Dockerfile_peer) to create a docker/singularity/charliecloud/... image.
> We found that using the conda env for calculating PEER factors might result in very slow behaviour, so we recommend using the Dockerfile

## Background

PEER is a factor analysis method which, despite being relatively old, is still
being used throughout scientific literature. Installation of PEER can be tricky,
which is why I provide this conda env definition including R-based PEER and tidyverse as well as the [Dockerfile](./Dockerfile_peer).

## Installation

### conda

As usual with conda, you can simply create a new environment using the provided 'rpeer.yml' or 'rpeer_explicit.yml' file (the 'explicit' file is a direct export of my working conda env):

```
~: git clone https://github.com/jhawe/rpeer.git
~: cd rpeer/
~: conda env create -f rpeer.yml
```

> Please note that specifying `r-cli` in the env file is necessary in order for tidyverse to work properly at the time of writing this.

> General note: I usually recommend using '[mamba](https://mamba.readthedocs.io/en/latest/user_guide/mamba.html)' instead of the `conda` command to speed up environment solving. It seems that the original `conda` command can also run into errors when solving the environment where `mamba` doesn't.

You can then activate the environment and use PEER as follows:

```
~: conda activate rpeer

~: R
[...]
> library(peer)
> 
[...]
```

### docker

This respository now provides a [PEER dockerfile](./Dockerfile_peer) which can be used to build your own docker/singularity/charliecloud image. The dockerfile includes some basic packages for more advanced data manipulation in R (dplyr, magrittr, readr).
The docker image is provided also on [docker hub](https://hub.docker.com/r/jhawe/peer).

## Application

Just a few notes on application of PEER (see also the [original publication](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3398141/):
I provide a simple script to 'correct for peer factors' in this repository ([utils_peer.R](scripts/utils_peer.R)).

1. PEER assumes a NxG matrix, with N=number of individuals and G=number of genes/molecular entities
2. to be feasible, number of factors to be estimated should not by set above 100 (default: N / 4)
