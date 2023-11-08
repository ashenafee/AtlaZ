#' Annotate IAD data
#'
#' This function adds columns to the input dataframe containing the distance of
#' the fish from the stimulus, the angle of the fish relative to the stimulus,
#' and the time since the stimulus was presented.
#'
#' @param data A dataframe of position of the fish and the stimulus over time.
#'             The dataframe should have the following columns:
#'             - xFish
#'             - yFish
#'             - xStim
#'             - yStim
#'             - time
#' @return An annotated dataframe.
#' @export
annotateIAD <- function(data) {
    # Calculate distance from stimulus
    data$distance <- sqrt((data$xFish - data$xStim)^2 +
                              (data$yFish - data$yStim)^2)
    # Calculate angle from stimulus
    data$angle <- atan2(data$yFish - data$yStim, data$xFish - data$xStim)
    # Calculate time since stimulus
    data$time_since_stim <- data$time - data$time[1]
    return(data)
}