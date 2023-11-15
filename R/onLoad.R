#' Fetch All Pathways
#'
#' This function fetches all zebrafish pathways from WikiPathways.
#'
#' @return A data frame containing all zebrafish pathways.
#' @export
#' @examples
#' fetchAllPathways()
fetchAllPathways <- local({
    pathways <- NULL

    function() {
        if (is.null(pathways)) {
            pathways <<- rWikiPathways::listPathways("Danio rerio")
        }

        return(pathways)
    }
})

# Define the .onLoad function
.onLoad <- function(libname, pkgname) {
    fetchAllPathways()
}

# [END]
