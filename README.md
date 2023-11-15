
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

| Function                                                       | Description                            |
|----------------------------------------------------------------|----------------------------------------|
| `downloadFromZfin(dataset: str, fileName: str, headers: bool)` | Downloads a dataset from ZFIN.         |
| `downloadFromZfinMultiple(data: data.frame)`                   | Downloads multiple datasets from ZFIN. |

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
More on this data formatting is available [here](./docs/input.md).

## Contributions

My name is Ashenafee Mandefro, and I am the author of this package. I’m
developing this package as a part of a course project for [BCB410H1:
Applied
Bioinformatics](https://artsci.calendar.utoronto.ca/course/bcb410h1)
during the Fall 2023 semester at the University of Toronto. You can see
more of my projects [here](https://github.com/ashenafee).

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

## Acknowledgements

## Table of Contents

- [AtlaZ](#atlaz)
  - [Description](#description)
  - [Installation](#installation)
  - [Overview](#overview)
    - [Data Retrieval](#data-retrieval)
    - [Data Processing](#data-processing)
    - [Data Analysis](#data-analysis)
  - [Contributions](#contributions)
  - [References](#references)
  - [Acknowledgements](#acknowledgements)
  - [Table of Contents](#table-of-contents)
  - [About](#about)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installing](#installing)
  - [Usage](#usage)
    - [Data](#data)

## About

## Getting Started

### Prerequisites

AtlaZ requires the following packages to be installed:

- [Insert Dependencies Here…]()

### Installing

To install AtlaZ, run the following code in R:

``` r
devtools::install_github("github.com/ashenafee/AtlaZ")
```

## Usage

### Data

AtlaZ requires the following data to be provided:

- [Insert Data Here…]()

You can see examples of the format that AtlaZ expects
[here](./docs/input.md).
