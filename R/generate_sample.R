#' Generate Sample Data for Fish and Stimulus Movement
#'
#' This function generates a sample data frame representing the movement of a
#' fish and a stimulus over time. The stimulus moves in a circle, while the
#' fish moves randomly.
#'
#' @param time The total time for which to generate data.
#' @param step The time step between each data point.
#' @return A data frame with columns: time, xFish, yFish, xStim, yStim.
#' @export
#' @examples
#' generate_data(10, 0.1)
generateData <- function(time, step) {
    # Parameters for the stimulus movement
    stimRadius <- 1
    stimSpeed <- 2 * pi / time # complete a circle in the given time

    # Initialize data frame to store the results
    data <- data.frame(
        time = numeric(), xFish = numeric(), yFish = numeric(),
        xStim = numeric(), yStim = numeric()
    )

    # Initialize fish position
    xFish <- 0
    yFish <- 0

    for (t in seq(0, time, by = step)) {
        # Calculate the stimulus position
        xStim <- stimRadius * cos(stimSpeed * t) + stimRadius
        yStim <- stimRadius * sin(stimSpeed * t) + stimRadius

        # Update fish movement based on previous position
        xFish <- xFish + rnorm(1, mean = 0, sd = 0.1)
        yFish <- yFish + rnorm(1, mean = 0, sd = 0.1)

        # Add the data to the data frame
        data <- rbind(data, c(t, xFish, yFish, xStim, yStim))
    }

    # Set the names of the data frame
    names(data) <- c("time", "xFish", "yFish", "xStim", "yStim")

    return(data)
}
