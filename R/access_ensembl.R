#' Access gene information from Ensembl Version 110
#'
#' @param geneSymbol A character string representing the gene symbol.
#' @return A data frame containing gene information.
#' @examples
#' getGeneInfo("rara")
#' getGeneInfo("rargb")
#'
#' @export
#' @importFrom biomaRt useEnsembl getBM
getGeneInfo <- function(geneSymbol) {
    # Use the zebrafish gene dataset from Ensembl
    ensembl <- biomaRt::useEnsembl(biomart = "genes",
                                   dataset = "drerio_gene_ensembl",
                                   version = "110")

    # Fetch the gene information using biomaRt
    results <- biomaRt::getBM(attributes = c("external_gene_name",
                                             "external_transcript_name",
                                             "zfin_id_id",
                                             "zfin_id_symbol",
                                             "zfin_id_trans_name",
                                             "ensembl_gene_id",
                                             "ensembl_transcript_id",
                                             "ensembl_peptide_id",
                                             "description",
                                             "start_position",
                                             "end_position",
                                             "strand",
                                             "transcript_start",
                                             "transcript_end"), 
                              filter = "external_gene_name", value = geneSymbol,
                              mart = ensembl)

    # Return the results
    return(results)
}

#' Verify that a gene symbol is valid
#'
#' @param geneSymbol A character string representing the gene symbol.
#' @param geneInfo A data frame containing gene information.
#' @return A boolean indicating whether the gene symbol is valid.
#' @examples
#' geneInfo <- getGeneInfo("rara")
#' isGeneSymbol("rara", geneInfo)
#'
#' geneInfo <- getGeneInfo("rargb")
#' isGeneSymbol("rargb", geneInfo)
#'
#' @export
isGeneSymbol <- function(geneSymbol, geneInfo) {
    # If the query returns any results, the gene symbol is valid
    return(any(geneInfo$external_gene_name == geneSymbol))
}