#' Import Gene Expression Data
#'
#' This function imports gene expression data from a file path provided.
#' The expected format is tab-delimited. It performs checks to ensure the
#' file exists and can be read before loading the data.
#'
#' @param filepath A string representing the path to the gene expression data
#' file.
#' @return A `data.frame` containing gene expression data.
#' @examples
#' gene_data <- importGeneExpressionData("inst/extdata/expression_data.txt")
#' head(gene_data)
#' @export
importGeneExpressionData <- function(filepath) {
    # File existence and readability check
    if (!file.exists(filepath)) {
        stop("File does not exist: ", filepath)
    }
    if (!file.access(filepath, 4)) {
        stop("File is not readable: ", filepath)
    }
    # Read and return data
    geneData <- read.table(filepath, header = TRUE, sep = "\t",
                           stringsAsFactors = FALSE)
    return(geneData)
}

# [END]
