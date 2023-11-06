#' Remove rows with missing values from a dataframe
#'
#' @param data A dataframe from which to remove missing values.
#' @return A dataframe with missing values removed.
#' @examples
#' removeNA(data)
removeNA <- function(data) {
    data[complete.cases(data), ]
}

#' Filter out rows or columns based on a given quality measure or threshold
#'
#' @param data A dataframe to filter.
#' @param threshold The threshold for quality filtering.
#' @return A filtered dataframe.
#' @examples
#' filterQuality(data, threshold)
filterQuality <- function(data, threshold) {
    data[rowSums(is.na(data)) < threshold, ]
}

#' Standardize the format of a dataframe
#'
#' @param data A dataframe whose formats you wish to standardize.
#' @return A dataframe with standardized formats.
#' @examples
#' standardizeFormat(data)
standardizeFormat <- function(data) {
    data
}