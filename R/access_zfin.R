#' Access gene expression data from ZFIN
#'
#' @param zfinId A character string representing the gene's ZFIN ID.
#' @return A list containing gene expression data.
#' @examples
#' getGeneExpression("ZDB-GENE-980526-284")
#' getGeneExpression("ZDB-GENE-000210-1")
#' @export
getGeneExpression <- function(zfinId) {
    # Open inst/extdata/wildtype-expression_fish.tsv if it exists
    if (zfinExpressionDataExists("inst/extdata/")) {
        zfinExpressionData <-
            readr::read_tsv("inst/extdata/wildtype-expression_fish.tsv")
    } else {
        # Download the data
        zfinExpressionData <- downloadZfinWTExpressionData("inst/extdata/")
    }


}

#' Access mutation information from ZFIN
#'
#' @param zfinId A character string representing the gene's ZFIN ID.
#' @return A list containing mutation information.
#' @examples
#' getZfinMutatationInfo("ZDB-GENE-980526-284")
#'
#' @export
getZfinMutatationInfo <- function(zfinId) {
    # Construct the URL
    url <- paste0("https://zfin.org/action/api/marker/",
                  zfinId, "/mutations?limit=10&page=1")

    # Fetch the JSON
    json <- jsonlite::fromJSON(url, flatten = TRUE)

    # Fetch json[results]
    json <- json$results

    # Clean up the column names
    colnames(json) <- c("zdbID", "name", "abbreviation", "suppliers",
                        "affectedGenes", "tgConstructs",
                        "geneLocalizationStatement",
                        "transcriptConsequenceStatement", "type", "typeDisplay",
                        "mutagen")

    # Return the mutation information
    return(json)
}

#' Parse gene ZFIN ribbon summary
#'
#' @param zfinId A character string representing the gene's ZFIN ID.
#' @return A list containing gene ZFIN ribbon summary.
#' @examples
#' getZfinRibbonSummary("ZDB-GENE-980526-284")
#'
#' @export
getZfinRibbonSummary <- function(zfinId) {

    # Construct the URL
    url <- paste0("https://zfin.org/action/api/marker/",
                  zfinId, "/expression/ribbon-summary")

    # Fetch the JSON
    json <- jsonlite::fromJSON(url, flatten = TRUE)

    # Get the anatomy
    anatomy <- getZfinAnatomy(json)

    # Get the stage range
    stageRange <- getZfinStageRange(json)

    # Get the cellular component
    cellularComponent <- getZfinCellularComponent(json)

    # Return the gene ZFIN ribbon summary
    return(list(anatomy = anatomy, stageRange = stageRange,
                cellularComponent = cellularComponent))
}

#' Access anatomy information from ZFIN
#'
#' @param json A list containing gene ZFIN ribbon summary.
#' @return A list containing anatomy information.
getZfinAnatomy <- function(json) {
    anatomy <- json[[1]]$groups

    # Return the anatomy
    return(anatomy[[1]])
}

#' Access stage range information from ZFIN
#'
#' @param json A list containing gene ZFIN ribbon summary.
#' @return A list containing stage range information.
getZfinStageRange <- function(json) {
    stageRange <- json[[1]]$groups

    # Return the stage range
    return(stageRange[[2]])
}

#' Access cellular component information from ZFIN
#'
#' @param json A list containing gene ZFIN ribbon summary.
#' @return A list containing cellular component information.
getZfinCellularComponent <- function(json) {
    cellularComponent <- json[[1]]$groups

    # Return the cellular component
    return(cellularComponent[[3]])
}
