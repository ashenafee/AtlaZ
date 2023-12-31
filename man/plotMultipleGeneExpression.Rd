% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expressionVisualization.R
\name{plotMultipleGeneExpression}
\alias{plotMultipleGeneExpression}
\title{Plot gene expression values over developmental stages for multiple genes}
\usage{
plotMultipleGeneExpression(data, geneNames, stages, useLog = FALSE)
}
\arguments{
\item{data}{A data frame with gene expression values. The data frame should
have one row per gene, and one column per developmental stage. The first
column should be the gene names.}

\item{geneNames}{A vector of gene names to plot.}

\item{useLog}{A boolean indicating whether to apply log transformation to
the expression values.}
}
\value{
A ggplot object representing the line plot.
}
\description{
This function performs the same functionality as `plotGeneExpression()`, but
for multiple genes. It creates a line plot of gene expression values for
multiple genes over different developmental stages.
}
\examples{
# Load the data from a TSV but remove the first 4 lines (comments)
data <- readr::read_tsv("./inst/extdata/ERAD_query_results.tsv", skip = 4)
# Plot the expression of rho and trpv1 over developmental stages with a log
# scale
plotMultipleGeneExpression(data, c("rho", "trpv1"), TRUE)
}
