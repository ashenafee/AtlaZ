#' Plot gene expression values over developmental stages
#'
#' @param data A data frame with gene expression values. The data frame should
#' have one row per gene, and one column per developmental stage. The first
#' column should be the gene names.
#' @param gene The name of the gene to plot.
#'
#' @return A ggplot object representing the line plot.
#' @export
#' @import ggplot2
#' @examples
#' # Load the data from a TSV but remove the first 4 lines (comments)
#' data <- readr::read_tsv("./inst/extdata/ERAD_query_results.tsv", skip = 4)
#' # Plot the expression of rara
#' plotGeneExpression(data, "rara")
plotGeneExpression <- function(data, gene) {
    # Subset the data for the selected gene. Check regardless of case.
    # Still must be an exact match.
    geneData <- data[grepl(gene, data$`Gene Name`, ignore.case = TRUE), ]

    # Reshape the data for plotting
    geneDataLong <- tidyr::pivot_longer(geneData, -c(`Gene ID`, `Gene Name`),
                                        names_to = "Stage",
                                        values_to = "Expression")

    # Organize the stages in the correct order


    # Create the plot
    plot <- ggplot2::ggplot(geneDataLong, ggplot2::aes(x = Stage,
                                                       y = Expression,
                                                       group = `Gene Name`)) +
        ggplot2::geom_line() +
        ggplot2::labs(title = paste("Expression of", gene,
                                    "over developmental stages"),
                      x = "Developmental stage",
                      y = "Expression value") +
        ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90,
                                                           hjust = 1))

    return(plot)
}

# [END]
