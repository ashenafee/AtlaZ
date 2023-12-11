#' S4 class for holding anatomy information
#'
#' This class represents anatomy information and provides methods for accessing
#' and manipulating it.
#'
#' @slot id The unique identifier of the anatomy.
#' @slot label The label of the anatomy.
#' @slot description The description of the anatomy.
#'
#' @exportClass Anatomy
setClass("Anatomy",
    slots = list(
        id = "character",
        label = "character",
        description = "character"
    )
)

#' Show an Anatomy Object
#'
#' Prints detailed information about an Anatomy object.
#'
#' @param object An Anatomy object.
#' @export
#' @method show Anatomy
setMethod("show", "Anatomy", function(object) {
    cat("\tLabel:", object@label, "\n")
    cat("\tDescription:", object@description, "\n")
})

#' S4 class for holding a list of Anatomy objects
#'
#' This class represents a list of Anatomy objects, where each object
#' corresponds to separate anatomy information.
#'
#' @slot anatomy A named list of Anatomy objects.
#'
#' @exportClass AnatomyList
setClass("AnatomyList",
    slots = list(
        anatomy = "list"
    )
)

#' Retrieve the list of anatomies from an AnatomyList object
#'
#' @param object An AnatomyList object
#' @return A list of anatomies
#' @export
setGeneric("getAnatomy", function(object) {
    standardGeneric("getAnatomy")
})
setMethod("getAnatomy", "AnatomyList", function(object) {
    object@anatomy
})

#' Set the anatomy for an object
#'
#' This function sets the anatomy for an object of class "AnatomyList".
#' The anatomy is stored in the @anatomy slot of the object.
#'
#' @param object An object of class "AnatomyList".
#' @param value A list of anatomies to be set.
#'
#' @return The modified object with the anatomy set.
#'
#' @export
setGeneric("setAnatomy", function(object, value) {
    standardGeneric("setAnatomy")
})
setMethod("setAnatomy", "AnatomyList", function(object, value) {
    object@anatomy <- value
    return(object)
})

#' Add an anatomy to an AnatomyList object
#'
#' This function adds an anatomy to an object of class "AnatomyList".
#' The anatomy is added to the @anatomy slot of the object.
#'
#' @param object An object of class "AnatomyList".
#' @param anatomy An anatomy to be added.
#'
#' @return The modified object with the anatomy added.
#'
#' @export
setGeneric("addAnatomy", function(object, anatomy) {
    standardGeneric("addAnatomy")
})
setMethod("addAnatomy", "AnatomyList", function(object, anatomy) {
    # Get the anatomy
    anatomyList <- object@anatomy

    # Get the anatomy ID
    anatomyID <- anatomy@id

    # Add the anatomy to the list
    anatomyList[[anatomyID]] <- anatomy

    # Set the anatomy
    object@anatomy <- anatomyList

    # Return the modified object
    return(object)
})

#' Show an AnatomyList Object
#'
#' Prints detailed information about an AnatomyList object.
#'
#' @param object An AnatomyList object.
#' @export
#' @method show AnatomyList
setMethod("show", "AnatomyList", function(object) {
    print(object@anatomy)
})

#' S4 class for holding ontology information
#'
#' This class represents ontology information and provides methods for accessing
#' and manipulating it.
#'
#' @slot id The unique identifier of the ontology.
#' @slot name The name of the ontology.
#' @slot definition The definition of the ontology.
#' @slot namespace The namespace of the ontology.
#' @slot description The description of the ontology.
#'
#' @exportClass Ontology
setClass("Ontology",
    slots = list(
        id = "character",
        name = "character",
        definition = "character",
        namespace = "character",
        description = "character"
    )
)

#' Show an Ontology Object
#'
#' Prints detailed information about an Ontology object.
#'
#' @param object An Ontology object.
#' @export
#' @method show Ontology
setMethod("show", "Ontology", function(object) {
    cat("\tName:", object@name, "\n")
    cat("\tDefinition:", object@definition, "\n")
    cat("\tNamespace:", object@namespace, "\n")
    cat("\tDescription:", object@description, "\n")
})

#' S4 class for holding a list of Ontology objects
#'
#' This class represents a list of Ontology objects, where each object
#' corresponds to a developmental stage.
#'
#' @slot ontologies A named list of Ontology objects. The names are the
#' developmental stages.
#'
#' @exportClass OntologyList
setClass("OntologyList",
    slots = list(
        ontologies = "list"
    )
)

#' Retrieve the list of ontologies from an OntologyList object
#'
#' @param object An OntologyList object
#' @return A list of ontologies
#' @export
setGeneric("getOntologies", function(object) {
    standardGeneric("getOntologies")
})
setMethod("getOntologies", "OntologyList", function(object) {
    object@ontologies
})

#' Set the ontologies for an object
#'
#' This function sets the ontologies for an object of class "OntologyList".
#' The ontologies are stored in the @ontologies slot of the object.
#'
#' @param object An object of class "OntologyList".
#' @param value A list of ontologies to be set.
#'
#' @return The modified object with the ontologies set.
#'
#' @export
setGeneric("setOntologies", function(object, value) {
    standardGeneric("setOntologies")
})
setMethod("setOntologies", "OntologyList", function(object, value) {
    object@ontologies <- value
    return(object)
})

#' Add an ontology to an OntologyList object
#'
#' This function adds an ontology to an object of class "OntologyList".
#' The ontology is added to the @ontologies slot of the object.
#'
#' @param object An object of class "OntologyList".
#' @param ontology An ontology to be added.
#'
#' @return The modified object with the ontology added.
#'
#' @export
setGeneric("addOntology", function(object, ontology) {
    standardGeneric("addOntology")
})
setMethod("addOntology", "OntologyList", function(object, ontology) {
    # Get the ontologies
    ontologies <- object@ontologies

    # Get the ontology ID
    ontologyID <- ontology@id

    # Add the ontology to the list
    ontologies[[ontologyID]] <- ontology

    # Set the ontologies
    object@ontologies <- ontologies

    # Return the modified object
    return(object)
})

#' Show an OntologyList Object
#'
#' Prints detailed information about an OntologyList object.
#'
#' @param object An OntologyList object.
#' @export
#' @method show OntologyList
setMethod("show", "OntologyList", function(object) {
    print(object@ontologies)
})

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
#' @name Gene
#' @title S4 Class Representing a Gene
#' @description This S4 class represents a gene with various attributes
#' including Ensembl ID, ZFIN ID, expression levels at different developmental
#' stages, and ontology information.
#'
#' @slot geneSymbol A character string representing the gene symbol.
#' @slot ensemblID A character string representing the Ensembl ID of the gene.
#' @slot zfinID A character string representing the ZFIN ID of the gene.
#' @slot anatomy A list representing the anatomy information related to the
#' gene.
#' @slot ontology A list representing the ontology information related to the
#' gene.
#' @exportClass Gene
setClass(
    "Gene",
    slots = c(
        geneSymbol = "character",
        ensemblID = "character",
        zfinID = "character",
        anatomy = "AnatomyList",
        ontology = "OntologyList"
    )
)

#' Constructor for Gene Object
#'
#' Creates a new Gene object with the specified gene symbol, Ensembl ID,
#' ZFIN ID, expression data, and ontology.
#'
#' @param geneSymbol A character string for the gene symbol (default is NA).
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
createGene <- function(
        geneSymbol = NA_character_,
        ensemblID = NA_character_,
        zfinID = NA_character_,
        anatomy = new("AnatomyList", anatomy = list()),
        ontology = new("OntologyList", ontologies = list())) {
    new("Gene",
        geneSymbol = geneSymbol,
        ensemblID = ensemblID,
        zfinID = zfinID,
        anatomy = anatomy,
        ontology = ontology
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

#' Set Anatomy Data for a Gene Object
#'
#' Updates the anatomy data of a Gene object.
#'
#' @param object A Gene object.
#' @param anatomy A list of anatomy data related to the gene.
#' @return The Gene object with updated anatomy data.
#' @export
#' @method setAnatomy Gene
setGeneric("setAnatomy", function(object, anatomy) {
    standardGeneric("setAnatomy")
})
setMethod("setAnatomy", "Gene", function(object, anatomy) {
    object@anatomy <- anatomy
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
    cat("Gene Symbol:", object@geneSymbol, "\n")
    cat("Ensembl ID:", object@ensemblID, "\n")
    cat("ZFIN ID:", object@zfinID, "\n")
    cat("Anatomy:\n")
    print(object@anatomy)
    cat("Ontology:\n")
    print(object@ontology)
})

# [END]
