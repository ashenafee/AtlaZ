### Installing RCy3

To use `RCy3`, I had to install `uchardet` from the CRAN archive.

```r
# Download package tarball from CRAN archive
url <- paste0(
    "https://cran.r-project.org/src/contrib/Archive/",
    "uchardet/uchardet_1.1.1.tar.gz"
)
pkgFile <- "uchardet_1.1.1.tar.gz"
download.file(url = url, destfile = pkgFile)
install.packages(c("ada", "ipred", "evd"))
install.packages(pkgs = pkgFile, type = "source", repos = NULL)
unlink(pkgFile)
```

*Code was adopted from [this](https://stackoverflow.com/a/24194531/7376957) StackOverflow answer.*

Only after was I able to run

```r
library(RCy3)
```

### Figuring Out Datasets

I wasn't sure how to initially focus my efforts for finding expression data, so
I decided to quantify how frequent each Assay was in ZFIN (my primary data
source). The assays, in alphabetical order, are:

- cDNA clones
- Gene Product Function
- Immunohistochemistry
- Intrinsic fluorescence
- Mass Spectrometry
- mRNA in situ hybridization
- Northern blot
- Nuclease protection assay
- other
- Primer extension
- Reverse transcription PCR
- RNA Seq
- Western blot

To do this, I used the following code, where `x` is a `data.frame` of all WT
expression data from ZFIN.

```r
for (col in unique(x$Assay)) {
    print(paste0(col, ": ", nrow(x[x$Assay == col, ])))
}
```