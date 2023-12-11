#' Extract Key Features from a Data Frame
#'
#' This function takes a data frame and returns a data frame where each row is a
#' developmental stage and the two columns are the gene IDs with the maximum and
#' minimum expression values for that stage.
#'
#' @param df A data frame to extract key features from.
#' @return A data frame where each row is a developmental stage and the two
#' columns are the gene IDs with the maximum and minimum expression values for
#' that stage.
#' @examples
#' # Load the data from a TSV but remove the first 4 lines (comments)
#' data <- readr::read_tsv("./inst/extdata/ERAD_query_results.tsv", skip = 4)
#' # Extract the key features
#' keyFeatures <- extractKeyFeatures(data)
#' @export
extractKeyFeatures <- function(df) {
    # Remove non-numeric columns
    numericDf <- df[sapply(df, is.numeric)]

    # Initialize a list to store the key information
    keyFeatures <- list()

    # Initialize lists to store max and min genes for each stage
    maxGenesList <- list()
    minGenesList <- list()

    # Set to store unique gene names
    allUniqueGenes <- character(0)

    # Iterate over each developmental stage and get the top 5 genes
    for (stage in colnames(numericDf)) {
        maxGeneNames <- getGeneNames(
            numericDf[[stage]],
            df$`Gene Name`,
            top = TRUE,
            n = 5
        )
        minGeneNames <- getGeneNames(
            numericDf[[stage]],
            df$`Gene Name`,
            top = FALSE,
            n = 5
        )

        maxGenesList[[stage]] <- strsplit(maxGeneNames, ", ")[[1]]
        minGenesList[[stage]] <- strsplit(minGeneNames, ", ")[[1]]

        # Collect unique genes
        allUniqueGenes <- unique(c(
            allUniqueGenes,
            maxGenesList[[stage]],
            minGenesList[[stage]]
        ))
    }

    # Fetch information for all unique genes in one call
    allGeneInfo <- getGeneInfo(allUniqueGenes)

    # Extract ontology information for each gene
    ontologyInfoList <- extractOntology(allGeneInfo)

    # Save the ontology information to keyFeatures under 'Ontology'
    keyFeatures$Ontology <- ontologyInfoList

    # Save the max and min genes to keyFeatures
    keyFeatures$MaxGenes <- maxGenesList
    keyFeatures$MinGenes <- minGenesList

    return(keyFeatures)
}


#' Get the names of the top or bottom n genes
#'
#' This function takes a vector of gene expression values and returns the names
#' of the top or bottom n genes.
#'
#' @param x A vector of gene expression values.
#' @param geneNames A vector of gene names.
#' @param top A boolean indicating whether to return the top or bottom n genes.
#' @param n The number of genes to return.
#' @return A character string containing the names of the top or bottom n genes.
#' @examples
#' # Load the data from a TSV but remove the first 4 lines (comments)
#' data <- readr::read_tsv("./inst/extdata/ERAD_query_results.tsv", skip = 4)
#' # Get the names of the top 5 genes
#' topGenes <- getGeneNames(data$`Stage 1`, data$`Gene Name`, top = TRUE, n = 5)
getGeneNames <- function(x, geneNames, top = TRUE, n = 5) {
    if (top) {
        indices <- order(x, decreasing = TRUE)[1:n]
    } else {
        indices <- order(x)[1:n]
    }
    return(paste(geneNames[indices], collapse = ", "))
}


#' Format the gene information for the AtlaZ LLM
#'
#' This function takes a list of ontology information for multiple genes and
#' formats it in a suitable JSON format to be passed in to the AtlaZ LLM.
#' The AtlaZ LLM is a modification of the Zephyr LLM available through Ollama.
#' It has been modified to work with the specific format used by this package so
#' it only focuses on summarising the expression information given the ontology
#' information.
#'
#' @param ontologyInformation A list containing the ontology information for =
#' multiple genes.
#' @return A JSON string containing the gene information.
#' @examples
#' # Load the data from a TSV but remove the first 4 lines (comments)
#' data <- readr::read_tsv("./inst/extdata/ERAD_query_results.tsv", skip = 4)
#' # Extract the key features
#' keyFeatures <- extractKeyFeatures(data)
#' # Format the gene information for the AtlaZ LLM
#' formattedFeatures <- formatForAtlaZ(keyFeatures$Ontology)
#' @export
#' @importFrom jsonlite toJSON
formatForAtlaZ <- function(ontologyInformation) {
    # Create a list to hold the gene information
    geneInfo <- list()

    # Create a list to hold the JSON value for each gene
    jsonList <- list()

    # Loop over the ontology information for each gene
    for (gene in names(ontologyInformation)) {
        # Get the ontology information for the gene
        ontologyInfo <- ontologyInformation[[gene]]
        # Assuming the first row contains the relevant information for the example
        goTerms <- ontologyInfo$`Ontology Definition`
        # Add the gene information to the list
        geneInfo[[gene]] <- list(GO_Terms = goTerms)
        # Add the gene information in JSON format to the list
        jsonList[[gene]] <- jsonlite::toJSON(geneInfo[[gene]], auto_unbox = TRUE)
    }

    return(jsonList)
}


#' Provide a snapshot of the data to an LLM to generate a description
#'
#' This function takes a data frame and returns a description of the data
#' generated by an LLM. Only a condensed version of the data is provided to the
#' LLM, to stay within a reasonable context length. The description is generated
#' by the LLM and returned to the user. This can be useful for understanding the
#' general structure of the data.
#'
#' @param df A data frame to describe.
#' @return A description of the data generated by an LLM.
#'
#' @examples
#' # Load the data from a TSV but remove the first 4 lines (comments)
#' data <- readr::read_tsv("./inst/extdata/ERAD_query_results.tsv", skip = 4)
#' # Describe the data
#' description <- describeData(data)
#' @export
describeData <- function(df) {
    # Grab the key features of the data
    keyFeatures <- extractKeyFeatures(df)

    # Define a robust prompt for the LLM to ensure output is consistent and
    # relevant
    prompt <- paste(
        "This data frame contains information about",
        nrow(df),
        "genes. The data frame has",
        ncol(df),
        "columns, which are:\n",
        paste(colnames(df), collapse = ", "),
        "\nBelow are the genes that were found to have the maximum and minimum",
        "expression values for each developmental stage:\n",
        # Add the max and min rows for each developmental stage
        paste(
            paste(
                "(Stage:",
                rownames(keyFeatures),
                "\tMax:",
                keyFeatures$MaxGeneID,
                "\tMin:",
                keyFeatures$MinGeneID,
                ")",
                sep = " "
            ),
            collapse = "\n"
        ),
        "\nThe following is a description of the data frame:",
        sep = " "
    )

    # Send the prompt to the LLM and return the response
    return(getAiResponse(prompt, ""))
}


#' Generate AI Response
#'
#' This function sends a POST request to a local server running an AI model and
#' returns the generated response. The AI model is used to generate a response
#' based on the provided prompt.
#'
#' @param prompt A character string to be used as the prompt for the AI model.
#' @param seed A character string to be used as the seed for the AI model.
#' @return A character string containing the AI model's response.
#' @examples
#' # Generate a response from the AI model
#' response <- getAiResponse("Hello, AI!")
#' @export
#' @importFrom httr POST
#' @importFrom httr content
#' @importFrom httr add_headers
getAiResponse <- function(prompt, seed = "") {
    url <- "http://localhost:11434/api/generate"

    headers <- c(
        "accept" = "application/json",
        "content-type" = "application/json"
    )

    payload <- list(
        "model" = "zephyr",
        "prompt" = prompt,
        "stream" = FALSE,
        "options" = list(
            "temperature" = 0.2,
            "top_k" = 0,
            "top_p" = 0.9
        )
    )

    # If a seed is provided, add it to the payload
    if (seed != "") {
        payload$options$seed <- seed
    }

    response <- httr::POST(url,
        body = payload, httr::add_headers(headers),
        encode = "json"
    )

    return(httr::content(response)$response)
}


#' Extract ontology information on a gene
#'
#' This function takes a data frame containing information on a gene and returns
#' a data frame containing ontology information on the gene.
#'
#' @param geneInfo A data frame containing information on the gene.
#' @return A data frame containing ontology information on the gene.
#' @examples
#' # Fetch ontology information on the gene
#' geneInfo <- getGeneInfo("rho")
#' ontology <- extractOntology(geneInfo)
#' @export
extractOntology <- function(geneInfoList) {
    # Check if geneInfoList is a valid list
    if (is.null(geneInfoList) || !is.list(geneInfoList)) {
        return(list())
    }

    # Initialize an empty list to store ontology data frames
    ontologyDfList <- list()

    # Iterate over each geneInfo data frame in the list
    for (geneSymbol in names(geneInfoList)) {
        geneInfo <- geneInfoList[[geneSymbol]]

        # Skip if geneInfo is empty or not a data frame
        if (is.null(geneInfo) || !is.data.frame(geneInfo) || nrow(geneInfo) == 0) {
            ontologyDfList[[geneSymbol]] <- data.frame() # Assign an empty data frame
            next
        }

        # Extract ontology information
        ontologyDf <- geneInfo[, c("go_id", "name_1006", "definition_1006", "namespace_1003"), drop = FALSE]

        # Rename columns for clarity
        colnames(ontologyDf) <- c("Ontology ID", "Ontology Name", "Ontology Definition", "Ontology Namespace")

        # Remove rows with NA in all ontology columns
        ontologyDf <- ontologyDf[rowSums(is.na(ontologyDf)) < ncol(ontologyDf), ]

        # Store the data frame in the list under the gene symbol
        ontologyDfList[[geneSymbol]] <- ontologyDf
    }

    # Return the list of ontology data frames
    return(ontologyDfList)
}
