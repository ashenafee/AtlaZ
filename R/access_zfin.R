#' Verify that a gene symbol is valid
#'
#' @param geneSymbol A character string representing the gene symbol.
#' @return A boolean indicating whether the gene symbol is valid.
#' @examples
#' isGeneSymbol("rara")
#' isGeneSymbol("rargb")
#' isGeneSymbol("rargb2")
isGeneSymbol <- function(geneSymbol) {
    # Use the zebrafish gene dataset from Ensembl
    ensembl <- biomaRt::useMart("ensembl", dataset = "drerio_gene_ensembl")
    # Query for the gene symbol
    genes <- biomaRt::getBM(attributes = c("external_gene_name"),
                            filters = "external_gene_name", 
                            values = geneSymbol, mart = ensembl)

    # If the query returns any results, the gene symbol is valid
    return(nrow(genes) > 0)
}

#' Access gene expression data from ZFIN
#'
#' @param geneSymbol A character string representing the gene symbol.
#' @return A list containing gene expression data.
#' @examples
#' getGeneExpression("rgra")
getGeneExpression <- function(geneSymbol) {

    # Check if the gene symbol is valid
    if (!isGeneSymbol(geneSymbol)) {
        stop("Invalid gene symbol")
    }
}

#' Access phenotype data from ZFIN
#'
#' @param geneSymbol A character string representing the gene symbol.
#' @return A list containing phenotype data.
#' @examples
#' getPhenotype("rargb")
getPhenotype <- function(geneSymbol) {
}
