
# AtlaZ

## Description

AtlaZ is a toolkit designed for the analysis and visualization of
zebrafish gene expression data across developmental stages and tissues.
This package facilitates the integration of neuroanatomical data, gene
expression profiles, and behavioural assays, enabling researchers to
explore the neurological underpinnings of behavior in zebrafish.

It is built as an R package, and is currently being developed as a part
of a course project for [BCB410H1: Applied
Bioinformatics](https://artsci.calendar.utoronto.ca/course/bcb410h1)
during the Fall 2023 semester at the University of Toronto.

## Installation

To install the latest development version of AtlaZ, run the following
code in R:

``` r
install.packages("devtools")
library("devtools")
devtools::install_github("ashenafee/AtlaZ", build_vignettes = TRUE)
library("AtlaZ")
```

## Overview

To get an overview of AtlaZ in your R session, run the following code:

``` r
ls("package:AtlaZ")
data(package = "AtlaZ")
browseVignettes("AtlaZ")
```

AtlaZ contains four categories of functions: **Data Retrieval**, **Data
Processing**, **Data Analysis**, and **Data Visualization**.

**Data Retrieval**

| Function                                                       | Description                                                                     |
|----------------------------------------------------------------|---------------------------------------------------------------------------------|
| `downloadFromZfin(dataset: str, fileName: str, headers: bool)` | Downloads a dataset from ZFIN.                                                  |
| `downloadFromZfinMultiple(data: data.frame)`                   | Downloads multiple datasets from ZFIN.                                          |
| `getZfinGeneExpression(zfinId: str)`                           | Gets the gene expression data for a gene from ZFIN.                             |
| `getZfinMutatationInfo(zfinId: str)`                           | Gets the mutation information for a gene from ZFIN.                             |
| `getZfinBackgroundInfo(zfinId: str)`                           | Gets background of a gene (anatomy, stage range, cellular component) from ZFIN. |

**Data Import**

| Function                                  | Description                               |
|-------------------------------------------|-------------------------------------------|
| `importGeneExpressionData(filepath: str)` | Imports gene expression data from a file. |

**Data Processing**

| Function                              | Description                  |
|---------------------------------------|------------------------------|
| `cleanData(data: data.frame)`         | Cleans up a dataset.         |
| `cleanDataMultiple(data: data.frame)` | Cleans up multiple datasets. |

**Data Analysis**

| Function                                                | Description                                                        |
|---------------------------------------------------------|--------------------------------------------------------------------|
| `getExpressionLevels(gene: str, dataset: str)`          | Gets the expression levels of a gene in different tissues.         |
| `getExpressionLevelsMultiple(genes: str, dataset: str)` | Gets the expression levels of multiple genes in different tissues. |

![Overview](./inst/extdata/MANDEFRO_A_A1.png) **Figure 1.** An overview
of the AtlaZ workflow and how it works on a high level.

AtlaZ can either use data provided by the user or from the [various
datasets](https://zfin.org/downloads) available on ZFIN. If data is
provided as input (i.e., it’s from the user and **not** from ZFIN), it
must be cleaned up and formatted first before it can be used by AtlaZ.
More on this data formatting is available [here](./docs/input.md). The
LLM output portion is a work-in-progress.

## Contributions

My name is Ashenafee Mandefro, and I am the author of this package. I’ve
worked with large databases similar to ZFIN in the past (i.e., GenBank,
Ensembl) and I want to adapt my skills to a zebrafish context, given
that fits into the context of my current thesis project at the [Lin
Lab](https://lin.csb.utoronto.ca/). You can see more of my projects
[here](https://github.com/ashenafee).

[ZFIN](https://www.zfin.org) is used as the primary data source in
AtlaZ. The datasets provided on their website are available
[here](https://zfin.org/downloads), and the data is licensed under the
[Creative Commons Attribution 4.0 International
License](https://creativecommons.org/licenses/by/4.0/).

Generative AI was used to help with creating the initial documentation
for each function. Specifically, GitHub Copilot was prompted with the
contents of the function and an initial docstring, and it generated a
final docstring that was then edited by the author. More information on
GitHub Copilot is available [here](https://copilot.github.com/).

## References

Bradford, Y. M., Van Slyke, C. E., Ruzicka, L., Singer, A., Eagle, A.,
Fashena, D., Howe, D. G., Frazer, K., Martin, R., Paddock, H., Pich, C.,
Ramachandran, S., & Westerfield, M. (2022). Zebrafish information
network, the knowledgebase for Danio rerio research. In V. Wood (Ed.),
Genetics (Vol. 220, Issue 4). Oxford University Press (OUP).
<https://doi.org/10.1093/genetics/iyac016>

Durinck, S., Moreau, Y., Kasprzyk, A., Davis, S., De Moor, B., Brazma,
A., & Huber, W. (2005). BioMart and Bioconductor: a powerful link
between biological databases and microarray data analysis.
Bioinformatics, Vol. 21, pp. 3439–3440.

Durinck, S., Spellman, P. T., Birney, E., & Huber, W. (2009). Mapping
identifiers for the integration of genomic datasets with the
R/Bioconductor package biomaRt. Nature Protocols, Vol. 4, pp. 1184–1191.

Wickham, H. (2016). ggplot2: Elegant Graphics for Data Analysis.
Retrieved from <https://ggplot2.tidyverse.org>

Wickham, H., François, R., Henry, L., Müller, K., & Vaughan, D. (2023).
dplyr: A Grammar of Data Manipulation. Retrieved from
<https://CRAN.R-project.org/package=dplyr>

Wickham, H. (2023). httr: Tools for Working with URLs and HTTP.
Retrieved from <https://CRAN.R-project.org/package=httr>

Wickham, H., Hester, J., & Bryan, J. (2023). readr: Read Rectangular
Text Data. Retrieved from <https://CRAN.R-project.org/package=readr>

Wickham, H., Vaughan, D., & Girlich, M. (2023). tidyr: Tidy Messy Data.
Retrieved from <https://CRAN.R-project.org/package=tidyr>

WikiPathways: a multifaceted pathway database bridging metabolomics to
other omics research. (2018, January). Nucleic Acids Res., Vol. 46,
pp. D661–D667.

White, R. J., Collins, J. E., Sealy, I. M., Wali, N., Dooley, C. M.,
Digby, Z., Stemple, D. L., Murphy, D. N., Billis, K., Hourlier, T.,
Füllgrabe, A., Davis, M. P., Enright, A. J., & Busch-Nentwich, E. M.
(2017). A high-resolution mRNA expression time course of embryonic
development in zebrafish. In eLife (Vol. 6). eLife Sciences
Publications, Ltd. <https://doi.org/10.7554/elife.30860>

## Acknowledgements

This package was developed as part of an assessment for 2023 BCB410H:
Applied Bioinformat- ics course at the University of Toronto, Toronto,
CANADA. AtlaZ welcomes issues, enhancement requests, and other
contributions. To submit an issue, use the GitHub issues.
