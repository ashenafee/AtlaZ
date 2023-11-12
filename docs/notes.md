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