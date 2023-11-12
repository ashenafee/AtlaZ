#' Select Pathway by ID
#'
#' This function selects a specific pathway from the list of all pathways.
#'
#' @param pathwayId A character string representing the ID of the pathway.
#' @return A data frame row containing the selected pathway.
#' @export
#' @examples
#' selectPathwayById("WP554")
selectPathwayById <- function(pathwayId) {
    pathways <- fetchAllPathways()
    pathway <- pathways[pathways$id == pathwayId, ]
    return(pathway)
}

#' Fetch Pathway by ID
#'
#' This function fetches a specific pathway from WikiPathways.
#'
#' @param pathwayId A character string representing the ID of the pathway.
#' @return The GPML file of the pathway.
#' @export
#' @examples
#' fetchPathwayById("WP554")
fetchPathwayById <- function(pathwayId) {
    pathwayString <- rWikiPathways::getPathway(pathwayId)[[1]]
    parsedPathway <- XML::xmlParse(pathwayString)

    return(parsedPathway)
}
