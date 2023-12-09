#' Remove rows with missing values from a dataframe
#'
#' @param data A dataframe from which to remove missing values.
#' @return A dataframe with missing values removed.
#' @examples
#' removeNA(data)
#' @export
removeNA <- function(data) {
    data[complete.cases(data), ]
}

#' Validate Gene Names
#'
#' This function checks whether the provided gene names are valid based on the
#' loaded data.
#' It returns a message if invalid gene names are detected.
#'
#' @param geneNames A vector of gene names provided by the user.
#' @param data The dataset containing valid gene names.
#' @return A character string with a message listing invalid gene names, or NULL
#' if all names are valid.
#' @export
#' @examples
#' data <- readr::read_tsv("path/to/dataset.tsv")
#' validateGeneNames(c("BRCA1", "INVALIDGENE"), data)
#' Validate Gene Names
#'
#' This function checks whether the provided gene names are valid based on the
#' loaded data.
#' It returns a message if invalid gene names are detected.
#'
#' @param geneNames A vector of gene names provided by the user.
#' @param data The dataset containing valid gene names.
#' @return A character string with a message listing invalid gene names, or NULL
#' if all names are valid.
#' @export
#' @examples
#' data <- readr::read_tsv("path/to/dataset.tsv")
#' validateGeneNames(c("BRCA1", "INVALIDGENE"), data)
validateGeneNames <- function(geneNames, data) {
    if (is.null(data)) {
        return(NULL)
    }

    # Filter out NA values from geneNames
    geneNames <- geneNames[!is.na(geneNames)]
    # Extract the list of valid gene names from the data
    validGeneList <- unique(data$`Gene Name`)
    # Check which gene names are not in the list of valid genes
    invalidGenes <- geneNames[!geneNames %in% validGeneList]

    if (length(invalidGenes) > 0) {
        return(paste("Invalid gene names:", paste(invalidGenes,
                                                  collapse = ", ")))
    }

    return(NULL)
}




# [END]
