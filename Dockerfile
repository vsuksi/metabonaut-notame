FROM bioconductor/bioconductor_docker:devel

LABEL name="rformassspectrometry/metabonaut" \
      url="https://github.com/rformassspectrometry/metabonaut" \
      maintainer="philippine.louail@eurac.edu" \
      description="Docker container to run the different tutorials hosted on metabonaut. This version bases on the Bioconductor devel docker image." \
      license="Artistic-2.0"

WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/

## Install the required packages
RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); \
    BiocManager::install(ask = FALSE, type = 'source'); \
    BiocManager::install(c('RCurl', 'xcms', 'RforMassSpectrometry/MsExperiment', 'SummarizedExperiment', \
    'RforMassSpectrometry/Spectra', 'RforMassSpectrometry/MetaboCoreUtils', 'limma', 'matrixStats', \
    'pander', 'RColorBrewer', 'pheatmap', 'vioplot', 'ggfortify', 'gridExtra', 'AnnotationHub', \
    'RforMassSpectrometry/CompoundDb', 'RforMassSpectrometry/MetaboAnnotation', 'RforMassSpectrometry/MsIO', \
    'RforMassSpectrometry/MsBackendMetaboLights'), ask = FALSE, dependencies = TRUE, type = 'source')"

## Install the package from the current directory, build vignettes, and ensure dependencies
RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); \
    devtools::install('.', dependencies = TRUE, type = 'source', build_vignettes = TRUE, repos = BiocManager::repositories())"