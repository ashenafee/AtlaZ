#' S4 Class Representing a Gene
#'
#' This S4 class represents a gene with various attributes including Ensembl ID,
#' ZFIN ID, expression levels at different developmental stages, and ontology
#' information.
#'
#' This object will be used to keep track of the gene information and pass it
#' around between functions. To initialize, it only requires the Ensembl ID
#' passed in as a parameter. The other attributes can be added later.
#'
#' @slot ensemblID A character string representing the Ensembl ID of the gene.
#' @slot zfinID A character string representing the ZFIN ID of the gene.
#' @slot expressionByStage A list representing expression levels of the gene
#' across different developmental stages.
#' @slot ontology A list representing the ontology information related to the
#' gene.
#' @exportClass Gene
setClass(
    "Gene",
    slots = c(
        ensemblID = "character",
        zfinID = "character",
        expressionByStage = "list",
        ontology = "list"
    )
)

#' Constructor for Gene Object
#'
#' Creates a new Gene object with the specified Ensembl ID, ZFIN ID, expression
#' data, and ontology.
#'
#' @param ensemblID A character string for the Ensembl ID of the gene (default
#' is NA).
#' @param zfinID A character string for the ZFIN ID of the gene (default is NA).
#' @param expressionByStage A list of expression data by developmental stage
#' (default is empty list).
#' @param ontology A list of ontology data related to the gene (default is empty
#' list).
#' @return An object of class Gene.
#' @export
#' @examples
#' myGene <- createGene(ensemblID = "ENSG00000139618")
createGene <- function(ensemblID = NA_character_, zfinID = NA_character_,
                       expressionByStage = list(), ontology = list()) {
    new("Gene",
        ensemblID = ensemblID, zfinID = zfinID,
        expressionByStage = expressionByStage, ontology = ontology
    )
}

#' Set ZFIN ID for a Gene Object
#'
#' Updates the ZFIN ID of a Gene object.
#'
#' @param object A Gene object.
#' @param zfinID A character string representing the new ZFIN ID.
#' @return The Gene object with updated ZFIN ID.
#' @export
#' @method setZfinID Gene
setGeneric("setZfinID", function(object, zfinID) standardGeneric("setZfinID"))
setMethod("setZfinID", "Gene", function(object, zfinID) {
    object@zfinID <- zfinID
    return(object)
})

#' Set Expression Data by Developmental Stage for a Gene Object
#'
#' Updates the expression data by developmental stage of a Gene object.
#'
#' @param object A Gene object.
#' @param expressionByStage A list of expression data by developmental stage.
#' @return The Gene object with updated expression data.
#' @export
#' @method setExpressionByStage Gene
setGeneric("setExpressionByStage", function(object, expressionByStage) {
    standardGeneric("setExpressionByStage")
})
setMethod("setExpressionByStage", "Gene", function(object, expressionByStage) {
    object@expressionByStage <- expressionByStage
    return(object)
})

#' Set Ontology Data for a Gene Object
#'
#' Updates the ontology data of a Gene object.
#'
#' @param object A Gene object.
#' @param ontology A list of ontology data related to the gene.
#' @return The Gene object with updated ontology data.
#' @export
#' @method setOntology Gene
setGeneric("setOntology", function(object, ontology) {
    standardGeneric("setOntology")
})
setMethod("setOntology", "Gene", function(object, ontology) {
    object@ontology <- ontology
    return(object)
})

#' Show a Gene Object
#'
#' Prints detailed information about a Gene object.
#'
#' @param object A Gene object.
#' @export
#' @method show Gene
setMethod("show", "Gene", function(object) {
    cat("Ensembl ID:", object@ensemblID, "\n")
    cat("ZFIN ID:", object@zfinID, "\n")
    cat("Expression by Stage:\n")
    print(object@expressionByStage)
    cat("Ontology:\n")
    print(object@ontology)
})
