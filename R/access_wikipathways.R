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