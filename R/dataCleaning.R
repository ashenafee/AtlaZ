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

# [END]
