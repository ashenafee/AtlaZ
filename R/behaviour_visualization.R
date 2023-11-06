#' Plot Movement Trajectory of Fish and Stimulus
#'
#' This function visualizes the movement paths of both the fish and the stimulus
#' over time.
#' It plots the x and y coordinates of the fish and the stimulus, showing how
#' the fish responds to the stimulus.
#'
#' @param behaviourData A dataframe with columns: x_fish, y_fish, x_stim,
#' y_stim, time.
#' @return A plot of the trajectory of fish and stimulus movement.
#' @export
#' @examples
#' plotTrajectory(behaviourData)
plotTrajectory <- function(behaviourData) {
    plot(behaviourData$x_fish, behaviourData$y_fish,
        type = "l", col = "blue",
        xlab = "X Coordinate", ylab = "Y Coordinate",
        main = "Fish Movement Trajectory"
    )
    lines(behaviourData$x_stim, behaviourData$y_stim, type = "l", col = "red")
    legend("topright",
        legend = c("Fish", "Stimulus"),
        col = c("blue", "red"), lty = 1, cex = 0.8
    )
}

#' Plot Distance of Fish from Stimulus Over Time
#'
#' Calculates and plots the distance between the fish and the stimulus over
#' time, providing insight into the fish's response to the stimulus.
#'
#' @param behaviourData A dataframe with columns: x_fish, y_fish, x_stim,
#' y_stim, time.
#' @return A plot showing the distance of the fish from the stimulus over time.
#' @export
#' @examples
#' plotDistanceOverTime(behaviourData)
plotDistanceOverTime <- function(behaviourData) {
    distances <- sqrt((behaviourData$x_fish - behaviourData$x_stim)^2 +
                          (behaviourData$y_fish - behaviourData$y_stim)^2)
    plot(behaviourData$time, distances,
        type = "b", pch = 19, col = "green",
        xlab = "Time", ylab = "Distance from Stimulus",
        main = "Distance of Fish from Stimulus Over Time"
    )
}

#' Heatmap of Fish Activity
#'
#' Generates a heatmap representing the frequency of the fish's positions,
#' indicating areas of high and low activity.
#' It requires the `ggplot2` library to create a 2D binning heatmap.
#'
#' @param behaviourData A dataframe with columns: x_fish, y_fish.
#' @return A heatmap of fish activity.
#' @export
#' @examples
#' heatmapActivity(behaviourData)
heatmapActivity <- function(behaviourData) {
    library(ggplot2)
    ggplot(behaviourData, aes(
        x = x_fish,
        y = y_fish
    )) +
        geom_bin2d(bins = 30) +
        scale_fill_gradient(low = "blue", high = "red") +
        labs(
            x = "X Coordinate", y = "Y Coordinate",
            title = "Heatmap of Fish Activity"
        ) +
        theme_minimal()
}
