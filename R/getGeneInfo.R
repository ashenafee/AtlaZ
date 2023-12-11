#' Access gene information from Ensembl Version 110
#'
#' This function retrieves gene information from Ensembl Version 110 for the
#' provided gene symbols. It uses the biomaRt package to access the zebrafish
#' gene dataset from Ensembl. The gene information is returned as a list of data
#' frames, where each data frame contains information on a single gene.
#'
#' @param geneSymbols A character vector representing gene symbols.
#' @return A list of data frames of information on each gene.
#' @examples
#' getGeneInfo(c("raraa", "rargb"))
#' @export
getGeneInfo <- function(geneSymbols) {
    # Check if geneSymbols is a character vector
    if (!is.character(geneSymbols)) {
        stop("geneSymbols must be a character vector")
    }

    # Check if geneSymbols is empty
    if (length(geneSymbols) == 0) {
        return(list())
    }

    # Use the zebrafish gene dataset from Ensembl
    ensembl <- biomaRt::useEnsembl(
        biomart = "genes",
        dataset = "drerio_gene_ensembl",
        version = "110"
    )

    # Fetch the gene information using biomaRt for all gene symbols
    results <- biomaRt::getBM(
        attributes = c(
            "external_gene_name",
            "external_transcript_name",
            "zfin_id_id",
            "zfin_id_symbol",
            "zfin_id_trans_name",
            "ensembl_gene_id",
            "ensembl_transcript_id",
            "ensembl_peptide_id",
            "go_id",
            "name_1006",
            "definition_1006",
            "namespace_1003",
            "description",
            "start_position",
            "end_position",
            "strand",
            "transcript_start",
            "transcript_end"
        ),
        filter = "external_gene_name", value = geneSymbols,
        mart = ensembl
    )

    # Create a list to store the Gene objects
    geneObjects <- list()

    # Create a named list of AnatomyList objects
    anatomyLists <- lapply(geneSymbols, function(x) {
        new("AnatomyList", anatomy = list())
    })
    names(anatomyLists) <- geneSymbols

    # Create a named list of OntologyList objects
    ontologyLists <- lapply(geneSymbols, function(x) {
        new("OntologyList", ontologies = list())
    })
    names(ontologyLists) <- geneSymbols

    # Loop through the gene symbols
    for (geneSymbol in geneSymbols) {
        # Get the gene information for the current gene symbol
        geneInfo <- results[results$external_gene_name == geneSymbol, ]

        if (nrow(geneInfo) == 0) {
            # Skip the current gene symbol if there is no gene information
            next
        }

        # Get the ZFIN ID for the current gene symbol
        zfinID <- geneInfo$zfin_id_id[1]

        # Add anatomy information to the AnatomyList object for the current
        # gene symbol
        anatomyInfo <- getZfinBackgroundInfo(zfinID)$anatomy
        anatomyLists[[geneSymbol]] <- createAnatomyObjects(
            anatomyInfo,
            anatomyLists[[geneSymbol]]
        )

        # Add ontology information to the OntologyList object for the current
        # gene symbol
        ontologyLists[[geneSymbol]] <- createOntologyObjects(
            geneInfo,
            ontologyLists[[geneSymbol]]
        )

        # Create a new Gene object
        gene <- new("Gene",
            geneSymbol = geneSymbol,
            ensemblID = geneInfo$ensembl_gene_id[1],
            zfinID = geneInfo$zfin_id_id[1],
            anatomy = anatomyLists[[geneSymbol]],
            ontology = ontologyLists[[geneSymbol]]
        )

        # Add the Gene object to the list of Gene objects
        geneObjects[[geneSymbol]] <- gene
    }

    return(geneObjects)
}


#' Add anatomy information to a list of AnatomyList objects
#'
#' @param anatomyInfo A data frame of anatomy information.
#' @param anatomyLists A list of AnatomyList objects.
#' @return A list of AnatomyList objects.
createAnatomyObjects <- function(anatomyInfo, anatomyLists) {
    for (i in seq_len(nrow(anatomyInfo))) {
        # Skip the current row if there is no anatomy ID
        if (anatomyInfo$id[i] == "") {
            next
        }

        # Skip the current row if the type is not "Term"
        if (anatomyInfo$type[i] != "Term") {
            next
        }

        # Create a new Anatomy object
        anatomy <- new(
            "Anatomy",
            id = anatomyInfo$id[i],
            label = anatomyInfo$label[i],
            description = anatomyInfo$description[i]
        )

        # Add the Anatomy object to the list of Anatomy objects
        anatomyLists <- AtlaZ::addAnatomy(anatomyLists, anatomy)
    }

    return(anatomyLists)
}

#' Add ontology information to a list of OntologyList objects
#'
#' @param geneInfo A data frame of gene information.
#' @param ontologyLists A list of OntologyList objects.
#' @return A list of OntologyList objects.
createOntologyObjects <- function(geneInfo, ontologyLists) {
    for (i in seq_len(nrow(geneInfo))) {
        # Create a new Ontology object if there's a valid GO ID
        if (geneInfo$go_id[i] == "") {
            next
        }
        ontology <- new("Ontology",
            id = geneInfo$go_id[i],
            name = geneInfo$name_1006[i],
            definition = geneInfo$definition_1006[i],
            namespace = geneInfo$namespace_1003[i],
            description = geneInfo$description[i]
        )

        # Add the Ontology object to the OntologyList object for the current
        # gene symbol
        ontologyLists <- AtlaZ::addOntology(ontologyLists, ontology)
    }

    return(ontologyLists)
}

# [END]
