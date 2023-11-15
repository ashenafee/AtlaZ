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
    pathways <- AtlaZ::fetchAllPathways()
    pathway <- pathways[pathways$id == pathwayId, ]
    return(pathway)
}

#' Fetch Pathway by ID
#'
#' This function fetches a specific pathway from WikiPathways.
#'
#' @param pathwayId A character string representing the ID of the pathway.
#' @param asXml A boolean indicating whether the pathway should be returned as
#' XML.
#' @return The GPML file of the pathway.
#' @export
#' @examples
#' fetchPathwayById("WP554")
fetchPathwayById <- function(pathwayId, asXml = TRUE) {
    # Use the WikiPathways API to fetch the pathway
    pathwayString <- rWikiPathways::getPathway(pathwayId)[[1]]

    # Check if the pathway should be returned as XML
    if (asXml) {
        pathwayString <- XML::xmlParse(pathwayString)
    }
    return(pathwayString)
}

#' Display Pathway by ID
#'
#' This function displays a specific pathway from WikiPathways through the
#' Cytoscape application (https://cytoscape.org/).
#'
#' @param pathwayId A character string representing the ID of the pathway.
#' @return The GPML file of the pathway.
#' @export
#' @examples
#' displayPathwayById("WP554")
displayPathwayById <- function(pathwayId) {
    RCy3::commandsRun(paste("wikipathways import-as-pathway id=",
                            pathwayId, sep = ""))
}

# [END]
