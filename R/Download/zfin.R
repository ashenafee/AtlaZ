library(httr)

#' Download Data from ZFIN (Single Dataset)
#'
#' This function downloads data from a specified ZFIN dataset.
#' The dataset name is checked against a predefined list of valid datasets.
#' If the dataset is valid, the function proceeds to download the data.
#'
#' @param dataset A string specifying the dataset to be downloaded.
#'                Must be a valid name in the predefined dictionary of datasets.
#' @param fileName A string specifying the name of the file to save the
#' downloaded data.
#' @param headers A boolean indicating whether to include headers in the
#' download.
#' @return Downloads the specified dataset and saves it as a file.
#' @export
#'
#' @examples
#' downloadFromZfin("sampleDataset", "sampleData.csv", TRUE)
downloadFromZfin <- function(dataset, fileName, headers) {
    # Predefined dictionary of valid datasets and their download URLs
    validDatasets <- list(
        # Anatomical Ontologies
        "Zebrafish Anatomy Term" =
            list(
                "url" = "https://zfin.org/downloads/anatomy_item.txt",
                "headers" = c("Anatomy ID", "Anatomy Name", "Start Stage ID",
                              "End Stage ID")
            ),
        "Zebrafish Stage Series" =
            list(
                "url" = "https://zfin.org/downloads/stage_ontology.txt",
                "headers" = c("Stage ID", "Stage OBO ID", "Stage Name",
                              "Begin Hours", "End Hours")
            ),
        # Gene Expression
        "Expression data for wildtype fish" =
            list(
                "url" =
                "https://zfin.org/downloads/wildtype-expression_fish.txt",
                "headers" = c("Gene ID", "Gene Symbol", "Fish Name",
                              "Super Structure ID", "Super Structure Name",
                              "Sub Structure ID", "Sub Structure Name",
                              "Start Stage", "End Stage", "Assay",
                              "Assay MMO ID", "Publication ID",
                              "Probe ID", "Antibody ID", "Fish ID")
            ),
        "Zebrafish Gene Expression by Stage and Anatomy Term" =
            list(
                "url" = "https://zfin.org/downloads/xpat_stage_anatomy.txt",
                "headers" = c("Expression Result ID", "Expression ID",
                              "Start Stage ID", "End Stage ID",
                              "Anatomy Super Term ID", "Anatomy Sub Term ID",
                              "Expression Found")
            ),
        # Phenotype Data
        "Gene Expression Phenotypes" =
            list(
                "url" =
                "https://zfin.org/downloads/gene_expression_phenotype.txt",
                "headers" = c("Gene Symbol", "Gene ID", "RO Term", "RO ID",
                              "Superstructure Name", "Superstructure ID",
                              "Substructure Name", "Substructure ID",
                              "Phenotype Keyword Name",
                              "Phenotype Keyword ID", "Phenotype Tag",
                              "Start Stage Name", "Start Stage ID",
                              "End Stage Name", "End Stage ID", "Assay",
                              "Assay MMO ID", "Probe ID", "Antibody Name",
                              "Antibody ID", "Fish ID", "Environment ID",
                              "Figure ID", "Publication ID", "PubMed ID")
            ),
        # ZFIN Alliance Data (1.0.1.4)
        "Expression" =
            list(
                "url" =
                "https://zfin.org/downloads/ZFIN_1.0.1.4_expression.json",
                "headers" = NULL
            )
    )

    # Check if the dataset is valid
    if (!dataset %in% names(validDatasets)) {
        stop("Invalid dataset. Please specify a valid dataset.")
    }

    # Get the download URL from the dictionary
    downloadUrl <- validDatasets[[dataset]]$url

    # Check if the downloads directory exists
    if (!dir.exists("downloads")) {
        dir.create("downloads", recursive = TRUE)
    }

    # Download the data
    if (headers) {

        # Attempt to download the data
        tryCatch(
            {
                httr::GET(downloadUrl, timeout(600),
                          write_disk(paste0("downloads/", fileName),
                              overwrite = TRUE
                          ))
                message("Data downloaded to ", paste0("downloads/", fileName))
            },
            error = function(e) {
                message("Error in downloading: ", e$message)
            }
        )

        # Add headers to the data
        h <- validDatasets[[dataset]]$headers

        # Read the data
        data <- readr::read_tsv(paste0("downloads/", fileName), col_names = h)

        # Save the data with headers
        readr::write_tsv(data, paste0("downloads/", fileName))
    } else {

        # Attempt to download the data
        tryCatch(
            {
                httr::GET(downloadUrl, timeout(600),
                          write_disk(paste0("downloads/", fileName),
                              overwrite = TRUE
                          ))
                message("Data downloaded to ", paste0("downloads/", fileName))
            },
            error = function(e) {
                message("Error in downloading: ", e$message)
            }
        )
    }

    cat("Download completed: ", fileName, "\n")

    # Return the path to the file
    return(paste0("downloads/", fileName))
}


#' Download Data from ZFIN (Multiple Datasets)
#'
#' This function downloads data from multiple ZFIN datasets.
#'
#' @param data A dataframe containing the datasets to be downloaded and their
#' corresponding file names.
#'
#' @return Downloads the specified datasets and saves them as files.
#' @export
#'
#' @examples
#' downloadFromZfinMultiple(
#'    data = data.frame(
#'       dataset = c("Zebrafish Anatomy Term", "Zebrafish Stage Series"),
#'       fileName = c("anatomy.csv", "stage.csv"),
#'       headers = c(TRUE, TRUE)
#'   )
#' )
downloadFromZfinMultiple <- function(data) {
    # Check if the downloads directory exists
    if (!dir.exists("downloads")) {
        dir.create("downloads", recursive = TRUE)
    }

    # Download the data
    for (i in seq_len(nrow(data))) {
        # Get the dataset name
        dataset <- data$dataset[i]

        # Get the file name
        fileName <- data$fileName[i]

        # Get the headers flag
        headers <- data$headers[i]

        # Attempt to download the data. If an error occurs, skip the dataset.
        tryCatch(
            {
                downloadFromZfin(dataset, fileName, headers)
            },
            error = function(e) {
                message("Error in downloading: ", e$message)
            }
        )
    }
}