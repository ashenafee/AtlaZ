#' Run the Shiny App for AtlaZ
#'
#' A function that runs the Shiny app for AtlaZ. This function is exported so
#' that it can be called from the command line.
#'
#' @return NULL
#'
#' @examples
#' \dontrun{
#' AtlaZ::runAtlaZ()
#' }
#'
#' @references
#' Grolemund, G. (2015). Learn Shiny - Video Tutorials. \href{https://shiny.rstudio.com/tutorial/}{Link}
#'
#' @export
#' @importFrom shiny runApp

runAtlaZ <- function() {
    appDir <- system.file("shiny-scripts",
        package = "AtlaZ"
    )
    actionShiny <- shiny::runApp(appDir, display.mode = "normal")
    return(actionShiny)
}
# [END]
