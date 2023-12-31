% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gene.R
\name{createGene}
\alias{createGene}
\title{Constructor for Gene Object}
\usage{
createGene(
  geneSymbol = NA_character_,
  ensemblID = NA_character_,
  zfinID = NA_character_,
  anatomy = new("AnatomyList", anatomy = list()),
  ontology = new("OntologyList", ontologies = list())
)
}
\arguments{
\item{geneSymbol}{A character string for the gene symbol (default is NA).}

\item{ensemblID}{A character string for the Ensembl ID of the gene (default
is NA).}

\item{zfinID}{A character string for the ZFIN ID of the gene (default is NA).}

\item{ontology}{A list of ontology data related to the gene (default is empty
list).}

\item{expressionByStage}{A list of expression data by developmental stage
(default is empty list).}
}
\value{
An object of class Gene.
}
\description{
Creates a new Gene object with the specified gene symbol, Ensembl ID,
ZFIN ID, expression data, and ontology.
}
\examples{
myGene <- createGene(ensemblID = "ENSG00000139618")
}
