FROM rocker/r-ubuntu:22.04

ADD Rprofile.site /usr/lib/R/etc/Rprofile.site

RUN apt-get update \
 && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
    libudunits2-dev libgdal-dev libgeos-dev \
    libproj-dev pandoc libmagick++-dev \
    libglpk-dev libnode-dev \
    wget

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.450/quarto-1.3.450-linux-amd64.deb \
    && DEBIAN_FRONTEND=noninteractive apt install ./quarto-1.3.450-linux-amd64.deb \
    && rm quarto-1.3.450-linux-amd64.deb

RUN install.r devtools rmarkdown quarto tidyverse gifski tidybayes brms \
 && installGithub.r rundel/checklist rundel/parsermd sta344-644-fa23/dukestm

RUN Rscript -e "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/'))" \
 && Rscript -e "cmdstanr::install_cmdstan()"

RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD ["bash"]

