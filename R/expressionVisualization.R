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
plotGeneExpression <- function(data, geneName, stages, useLog = FALSE) {
    geneData <- dplyr::filter(data, `Gene Name` == geneName)

    if (nrow(geneData) == 0) {
        stop("Specified gene not found in the data.")
    }

    longData <- tidyr::pivot_longer(geneData,
        cols = -c(`Gene ID`, `Gene Name`),
        names_to = "DevelopmentalStage",
        values_to = "ExpressionValue"
    )

    # Filter the data for the specified stages
    if (!is.null(stages)) {
        longData <- longData[longData$DevelopmentalStage %in% stages, ]
    }

    # Apply log transformation if specified
    if (useLog) {
        longData$ExpressionValue <- log1p(longData$ExpressionValue)
    }

    # Create the plot
    plot <- ggplot2::ggplot(longData, ggplot2::aes(
        x = DevelopmentalStage,
        y = ExpressionValue
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
        ggplot2::theme(axis.text.x = ggplot2::element_text(
            angle = 45,
            hjust = 1
        ))

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
plotMultipleGeneExpression <- function(data, geneNames, stages,
                                       useLog = FALSE) {
    combinedLongData <- data.frame()

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

        # Filter the data for the specified stages
        if (!is.null(stages)) {
            longData <- longData[longData$DevelopmentalStage %in% stages, ]
        }

        # Apply log transformation if specified
        if (useLog) {
            longData$ExpressionValue <- log1p(longData$ExpressionValue)
        }

        combinedLongData <- rbind(combinedLongData, longData)
    }

    # Filter out genes that were not found in the data
    geneNames <- unique(combinedLongData$GeneName)

    # Create the plot
    if (length(geneNames) <= 5) {
        title <- paste(
            "Expression of", paste(geneNames, collapse = ", "),
            "over Developmental Stages"
        )
    } else {
        title <- paste(
            length(geneNames), "genes analyzed over Developmental Stages"
        )
    }

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
        ggplot2::ggtitle(title) +
        ggplot2::guides(color = ggplot2::guide_legend(title = "Gene Name")) +
        ggplot2::theme_minimal() +
        ggplot2::theme(axis.text.x = ggplot2::element_text(
            angle = 45,
            hjust = 1
        ))

    return(plot)
}



# [END]
