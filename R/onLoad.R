# Define the function that generates and stores the variable
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
