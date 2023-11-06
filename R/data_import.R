# Purpose: Import neuroanatomical, gene expression, and behavioural data
# Author: Ashenafee Mandefro
# Date: 2023-11-06
# Version: 0.1.0
# Bugs and Issues: None

#' Import Neuroanatomical Data
#'
#' Reads and imports neuroanatomical data from a specified file path.
#' The data should be tab-delimited. This function checks for file existence
#' and readability before attempting to read the file.
#'
#' @param filepath A string representing the path to the neuroanatomical data
#' file.
#' @return A `data.frame` containing neuroanatomical data with appropriate
#' headers.
#' @examples
#' neuro_data <- importNeuroData("inst/extdata/neuroanatomical_data.tsv")
#' head(neuro_data)
#' @export
#' @seealso \code{\link{importGeneExpressionData}},
#' \code{\link{importBehaviouralData}}
#' @encoding UTF-8
importNeuroData <- function(filepath) {
  # File existence and readability check
    if (!file.exists(filepath)) {
    stop("File does not exist: ", filepath)
    }
    if (!file.access(filepath, 4)) {
        stop("File is not readable: ", filepath)
    }
    # Read and return data
    neuroData <- read.table(filepath, header = TRUE, sep = "\t",
                             stringsAsFactors = FALSE)
    return(neuro_data)
}

#' Import Gene Expression Data
#'
#' This function imports gene expression data from a file path provided.
#' The expected format is tab-delimited. It performs checks to ensure the
#' file exists and can be read before loading the data.
#'
#' @param filepath A string representing the path to the gene expression data file.
#' @return A `data.frame` containing gene expression data.
#' @examples
#' gene_data <- importGeneExpressionData("inst/extdata/gene_expression_data.txt")
#' head(gene_data)
#' @export
#' @seealso \code{\link{importNeuroData}}, \code{\link{importBehaviouralData}}
#' @encoding UTF-8
importGeneExpressionData <- function(filepath) {
    # File existence and readability check
    if (!file.exists(filepath)) {
        stop("File does not exist: ", filepath)
    }
    if (!file.access(filepath, 4)) {
        stop("File is not readable: ", filepath)
    }
    # Read and return data
    gene_data <- read.table(filepath, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
    return(gene_data)
}

#' Import Behavioural Data
#'
#' Imports behavioural assay data from a specified file path, expecting a
#' tab-delimited format. Ensures that the file exists and is readable prior
#' to importing the data.
#'
#' @param filepath A string representing the path to the behavioural assay data file.
#' @return A `data.frame` containing behavioural assay data.
#' @examples
#' behaviour_data <- importBehaviouralData("inst/extdata/behavioural_data.csv")
#' head(behaviour_data)
#' @export
#' @seealso \code{\link{importNeuroData}}, \code{\link{importGeneExpressionData}}
#' @encoding UTF-8
importBehaviouralData <- function(filepath) {
    # File existence and readability check
    if (!file.exists(filepath)) {
        stop("File does not exist: ", filepath)
    }
    if (!file.access(filepath, 4)) {
        stop("File is not readable: ", filepath)
    }
    # Read and return data
    behaviour_data <- read.csv(filepath, header = TRUE, sep = ",", stringsAsFactors = FALSE)
    return(behaviour_data)
}

# [END]