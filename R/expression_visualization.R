#' Plot gene expression values over developmental stages
#'
#' @param data A data frame with gene expression values. The data frame should
#' have one row per gene, and one column per developmental stage. The first
#' column should be the gene names.
#' @param gene The name of the gene to plot.
#'
#' @return A ggplot object representing the line plot.
#' @export
#' @examples
#' data <- read.delim("./inst/extdata/ERAD_query_results.tsv", header = TRUE,
#'                    stringsAsFactors = FALSE)
#' plotGeneExpression(data, "slc35a5")
plotGeneExpression <- function(data, gene) {
    # Check if ggplot2 is installed
    if (!requireNamespace("ggplot2", quietly = TRUE)) {
        stop("ggplot2 package is required for this function to work. 
        Please install it.")
    }

    # Subset the data for the selected gene
    geneData <- data[data$Gene.Name == gene, ]

    # Reshape the data for plotting
    geneDataLong <- tidyr::pivot_longer(geneData, -c(Gene.ID, Gene.Name),
                                        names_to = "Stage",
                                        values_to = "Expression")

    # Create the plot
    plot <- ggplot2::ggplot(geneDataLong, ggplot2::aes(x = Stage,
                                                       y = Expression,
                                                       group = Gene.Name)) +
        ggplot2::geom_line() +
        ggplot2::labs(title = paste("Expression of", gene,
                                    "over developmentalstages"),
                      x = "Developmental stage",
                      y = "Expression value") +
        ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90,
                                                           hjust = 1))

    return(plot)
}