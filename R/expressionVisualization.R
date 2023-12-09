#' Plot gene expression values over developmental stages
#'
#' This function creates a line plot of gene expression values for a specific
#' gene over different developmental stages. The line plot is an effective way
#' to visualize how the expression of a particular gene changes across different
#' stages of development. Each point on the line corresponds to a gene
#' expression value at a particular developmental stage, and the line's
#' progression shows the trend of these values over time. This can help
#' researchers identify patterns or anomalies in gene expression, which can be
#' critical in understanding gene function and its role in development.
#'
#' @param data A data frame with gene expression values. The data frame should
#' have one row per gene, and one column per developmental stage. The first
#' column should be the gene names.
#' @param gene The name of the gene to plot.
#' @param useLog A boolean indicating whether to use a log scale for the y-axis.
#'
#' @return A ggplot object representing the line plot.
#' @export
#' @import ggplot2
#' @examples
#' # Load the data from a TSV but remove the first 4 lines (comments)
#' data <- readr::read_tsv("./inst/extdata/ERAD_query_results.tsv", skip = 4)
#' # Plot the expression of rho over developmental stages with a log scale
#' plotGeneExpression(data, "rho", TRUE)
plotGeneExpression <- function(data, geneName, useLog = FALSE) {
    # Extract the row for the specified gene
    geneData <- dplyr::filter(data, `Gene Name` == geneName)

    # Check if the gene exists in the dataset
    if (nrow(geneData) == 0) {
        stop("Specified gene not found in the data.")
    }

    # Transform the data for plotting
    longData <- tidyr::pivot_longer(geneData,
        cols = -c(`Gene ID`, `Gene Name`),
        names_to = "DevelopmentalStage",
        values_to = "ExpressionValue"
    )

    # Identify NA stages and prepare them for annotation
    naStages <- longData$DevelopmentalStage[is.na(longData$ExpressionValue)]
    naStagesText <- paste("NA Stages:\n", paste(naStages, collapse = "\n"))

    # Remove rows with NA in Expression Value
    longData <- longData[!is.na(longData$ExpressionValue), ]

    # Apply log transformation if specified
    if (useLog) {
        longData$ExpressionValue <- log1p(longData$ExpressionValue)
    }

    # Create the gene expression plot using ggplot2
    plot <- ggplot2::ggplot(longData, ggplot2::aes(
        x = DevelopmentalStage,
        y = ExpressionValue, group = 1
    )) +
        ggplot2::geom_line() +
        ggplot2::geom_point() +
        ggplot2::xlab("Developmental Stage") +
        ggplot2::ylab(ifelse(useLog, "Log Transformed Expression Value",
            "Expression Value"
        )) +
        ggplot2::ggtitle(paste(
            "Expression of", geneName,
            "over Developmental Stages"
        )) +
        ggplot2::theme_minimal() +
        ggplot2::theme(
            panel.background = element_rect(fill = "white", colour = "white"),
            panel.grid.major = element_line(color = "#D3D3D3"),
            panel.grid.minor = element_line(color = "#D3D3D3", size = 0.25),
            plot.background = element_rect(fill = "white", colour = NA),
            axis.text.x = element_text(angle = 45, hjust = 1)
        ) +
        ggplot2::annotate("text",
            x = Inf, y = Inf, label = naStagesText,
            hjust = 1.05, vjust = 1.05, size = 3, color = "red",
            fontface = "bold"
        )

    return(plot)
}


#' Plot gene expression values over developmental stages for multiple genes
#'
#' This function performs the same functionality as `plotGeneExpression()`, but
#' for multiple genes. It creates a line plot of gene expression values for
#' multiple genes over different developmental stages.
#'
#' @param data A data frame with gene expression values. The data frame should
#' have one row per gene, and one column per developmental stage. The first
#' column should be the gene names.
#' @param geneNames A vector of gene names to plot.
#' @param useLog A boolean indicating whether to apply log transformation to
#' the expression values.
#'
#' @return A ggplot object representing the line plot.
#' @export
#' @import ggplot2
#' @import dplyr
#' @import tidyr
#' @examples
#' # Load the data from a TSV but remove the first 4 lines (comments)
#' data <- readr::read_tsv("./inst/extdata/ERAD_query_results.tsv", skip = 4)
#' # Plot the expression of rho and trpv1 over developmental stages with a log
#' # scale
#' plotMultipleGeneExpression(data, c("rho", "trpv1"), TRUE)
plotMultipleGeneExpression <- function(data, geneNames, useLog = FALSE) {
    # Initialize an empty data frame to hold all gene data
    combinedLongData <- data.frame()

    # Loop through each gene name to extract and transform its data
    for (geneName in geneNames) {
        geneData <- dplyr::filter(data, `Gene Name` == geneName)

        if (nrow(geneData) == 0) {
            warning(paste("Gene", geneName, "not found in the data."))
            next
        }

        longData <- tidyr::pivot_longer(geneData,
            cols = -c(`Gene ID`, `Gene Name`),
            names_to = "DevelopmentalStage",
            values_to = "ExpressionValue"
        )

        longData$GeneName <- geneName

        # Remove rows with NA in Expression Value
        longData <- longData[!is.na(longData$ExpressionValue), ]

        # Apply log transformation if specified
        if (useLog) {
            longData$ExpressionValue <- log1p(longData$ExpressionValue)
        }

        # Combine the data for this gene with the others
        combinedLongData <- rbind(combinedLongData, longData)
    }

    # Create the gene expression plot using ggplot2
    plot <- ggplot2::ggplot(combinedLongData, ggplot2::aes(
        x = DevelopmentalStage,
        y = ExpressionValue,
        group = GeneName,
        color = GeneName
    )) +
        ggplot2::geom_line() +
        ggplot2::geom_point() +
        ggplot2::xlab("Developmental Stage") +
        ggplot2::ylab(ifelse(useLog, "Log Transformed Expression Value",
            "Expression Value"
        )) +
        ggplot2::ggtitle(paste(
            "Expression of",
            length(unique(combinedLongData$GeneName)),
            "genes over Developmental Stages"
        )) +
        ggplot2::guides(color = ggplot2::guide_legend(title = "Gene Name")) +
        ggplot2::theme_minimal() +
        ggplot2::theme(
            panel.background = element_rect(
                fill = "white",
                colour = "white"
            ),
            panel.grid.major = element_line(color = "#D3D3D3"),
            panel.grid.minor = element_line(color = "#D3D3D3", size = 0.25),
            plot.background = element_rect(fill = "white", colour = NA),
            axis.text.x = element_text(angle = 45, hjust = 1)
        )

    return(plot)
}


# [END]
