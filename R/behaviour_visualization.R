#' Plot Movement Trajectory of Fish and Stimulus
#'
#' This function visualizes the movement paths of both the fish and the stimulus
#' over time.
#' It plots the x and y coordinates of the fish and the stimulus, showing how
#' the fish responds to the stimulus.
#'
#' @param behaviourData A dataframe with columns: xFish, yFish, xStim,
#' yStim, time.
#' @return A plot of the trajectory of fish and stimulus movement.
#' @export
#' @examples
#' plotTrajectory(behaviourData)
plotTrajectory <- function(behaviourData) {
    plot(behaviourData$xFish, behaviourData$yFish,
        type = "l", col = "blue",
        xlab = "X Coordinate", ylab = "Y Coordinate",
        main = "Fish Movement Trajectory"
    )
    lines(behaviourData$xStim, behaviourData$yStim, type = "l", col = "red")
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
#' @param behaviourData A dataframe with columns: xFish, yFish, xStim,
#' yStim, time.
#' @return A plot showing the distance of the fish from the stimulus over time.
#' @export
#' @examples
#' plotDistanceOverTime(behaviourData)
plotDistanceOverTime <- function(behaviourData) {
    distances <- sqrt((behaviourData$xFish - behaviourData$xStim)^2 +
                          (behaviourData$yFish - behaviourData$yStim)^2)
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
#' @param behaviourData A dataframe with columns: xFish, yFish.
#' @return A heatmap of fish activity.
#' @export
#' @examples
#' heatmapActivity(behaviourData)
heatmapActivity <- function(behaviourData) {
    library(ggplot2)
    xFish <- behaviourData$xFish
    yFish <- behaviourData$yFish
    ggplot(behaviourData, aes(
        x = xFish,
        y = yFish
    )) +
        geom_bin2d(bins = 30) +
        scale_fill_gradient(low = "blue", high = "red") +
        labs(
            x = "X Coordinate", y = "Y Coordinate",
            title = "Heatmap of Fish Activity"
        ) +
        theme_minimal()
}

#' Animation of Fish and Stimulus Movement
#'
#' This function creates an animation of the movement paths of both the fish
#' and the stimulus over time. It plots the x and y coordinates of the fish and
#' the stimulus, showing how the fish responds to the stimulus.
#'
#' @param behaviourData A dataframe with columns: xFish, yFish, xStim,
#' yStim, time.
#' @param filename The name of the file where the animation will be saved.
#' @return Saves the animation to a file.
#' @export
#' @examples
#' animateMovement(behaviourData, "animation.gif")
animateMovement <- function(behaviourData, filename = "animation.gif", fps = 20,
                            duration = 5) {
    library(ggplot2)
    library(gganimate)
    library(readr)
    library(gifski)
    library(png)

    # Explicitly set the column variables
    xFish <- behaviourData$xFish
    yFish <- behaviourData$yFish
    xStim <- behaviourData$xStim
    yStim <- behaviourData$yStim

    p <- ggplot() +
        geom_point(data = behaviourData, aes(x = xFish, y = yFish,
                                             color = "Fish")) +
        geom_point(data = behaviourData, aes(x = xStim, y = yStim,
                                             color = "Stimulus")) +
        scale_color_manual(values = c("Fish" = "blue", "Stimulus" = "red")) +
        labs(color = "Type")
    p <- p + transition_time(time) + labs(title = "Time: {frame_time}")

    g <- animate(p, duration = duration, fps = fps, width = 1000, height = 1000,
                 renderer = gifski_renderer())

    anim_save(filename, g)
}
