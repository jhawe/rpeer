This repository simply provides a conda environment definition
to install the R version of 'PEER' (see [here](https://github.com/PMBio/peer) for details on PEER) alongside
'tidyverse'.

## Background

PEER is a factor analysis method which, despite being relatively old, is still
being out throughout scientific literature. Installation of PEER can be tricky,
which is why I provide this conda env definition including R-based PEER and tidyverse.

## Installation

As usual with conda, you can simply create a new environment using the provided 'rpeer.yml' or 'rpeer_explicit.yml' file (the 'explicit' file is a direct export of my working conda env):

```
git clone 
cd rpeer/
conda env create -f rpeer.yml
```

> Please note that specifying `r-cli` in the env file is necessary in order for tidyverse to work properly at the time of writing this.

> General note: I usually recommend using '[mamba](https://mamba.readthedocs.io/en/latest/user_guide/mamba.html)' instead of the 'conda' command to speed up environment solving.

You can then activate the environment and use PEER as follows:

```
conda activate rpeer
```

## Alternative: docker

There is also a docker image available through quai.io, located at [https://quay.io/repository/biocontainers/r-peer](https://quay.io/repository/biocontainers/r-peer)
This image contains a simple R PEER installation.

