#' Access gene information from Ensembl Version 110
#'
#' This function retrieves gene information from Ensembl Version 110 for the
#' provided gene symbols. It uses the biomaRt package to access the zebrafish
#' gene dataset from Ensembl. The gene information is returned as a list of data
#' frames, where each data frame contains information on a single gene.
#'
#' @param geneSymbols A character vector representing gene symbols.
#' @return A list of data frames of information on each gene.
#' @examples
#' getGeneInfo(c("raraa", "rargb"))
#' @export
getGeneInfo <- function(geneSymbols) {
    # Use the zebrafish gene dataset from Ensembl
    ensembl <- biomaRt::useEnsembl(
        biomart = "genes",
        dataset = "drerio_gene_ensembl",
        version = "110"
    )

    # Fetch the gene information using biomaRt for all gene symbols
    results <- biomaRt::getBM(
        attributes = c(
            "external_gene_name",
            "external_transcript_name",
            "zfin_id_id",
            "zfin_id_symbol",
            "zfin_id_trans_name",
            "ensembl_gene_id",
            "ensembl_transcript_id",
            "ensembl_peptide_id",
            "go_id",
            "name_1006",
            "definition_1006",
            "namespace_1003",
            "description",
            "start_position",
            "end_position",
            "strand",
            "transcript_start",
            "transcript_end"
        ),
        filter = "external_gene_name", value = geneSymbols,
        mart = ensembl
    )

    # Create a list where each entry is a data frame containing information on a
    # single gene

    # Create a list of gene symbols
    geneSymbols <- unique(results$external_gene_name)

    # Create a list of data frames
    geneInfo <- lapply(geneSymbols, function(geneSymbol) {
        # Filter the results to only include the current gene symbol
        geneInfo <- results[results$external_gene_name == geneSymbol, ]

        # Return the gene information
        return(geneInfo)
    })

    # Make the genes accessible by their symbol
    names(geneInfo) <- geneSymbols

    # Return the gene information
    return(geneInfo)
}

# [END]
