library(AtlaZ)

test_that("Ontology class works", {
    ontology <- new("Ontology",
        id = "GO:0048384",
        name = "retinoic acid receptor signaling pathway",
        definition = paste(
            "The series of molecular signals generated as a consequence of a",
            " retinoic acid receptor binding to one of its physiological",
            " ligands."
        ),
        namespace = "biological_process",
        description = paste(
            "retinoic acid receptor, alpha a [Source:NCBI gene (formerly",
            " Entrezgene);Acc:30680]"
        )
    )

    # Verify that the slots are set correctly
    expect_equal(ontology@id, "GO:0048384")
    expect_equal(ontology@name, "retinoic acid receptor signaling pathway")
    expect_equal(
        ontology@definition,
        paste(
            "The series of molecular signals generated as a consequence of a",
            " retinoic acid receptor binding to one of its physiological",
            " ligands."
        )
    )
    expect_equal(ontology@namespace, "biological_process")
    expect_equal(
        ontology@description,
        paste(
            "retinoic acid receptor, alpha a [Source:NCBI gene (formerly",
            " Entrezgene);Acc:30680]"
        )
    )
})


test_that("OntologyList class works", {
    # Create a list of Ontology objects
    ontologies <- list(
        new("Ontology",
            id = "GO:0048384",
            name = "retinoic acid receptor signaling pathway",
            definition = paste(
                "The series of molecular signals generated as a consequence of",
                " a retinoic acid receptor binding to one of its physiological",
                " ligands."
            ),
            namespace = "biological_process",
            description = paste(
                "retinoic acid receptor, alpha a [Source:NCBI gene (formerly",
                " Entrezgene);Acc:30680]"
            )
        ),
        new("Ontology",
            id = "GO:0004879",
            name = "nuclear receptor activity",
            definition = paste(
                "A DNA-binding transcription factor activity regulated by",
                " binding to a ligand that modulates the transcription of",
                " specific gene sets transcribed by RNA polymerase II. Nuclear",
                " receptor ligands are usually lipid-based (such as a steroid",
                " hormone) and the binding of the ligand to its receptor often",
                " occurs in the cytoplasm, which leads to its tranlocation to",
                " the nucleus."
            ),
            namespace = "molecular_function",
            description = paste(
                "retinoic acid receptor, alpha a [Source:NCBI gene (formerly",
                " Entrezgene);Acc:30680]"
            )
        )
    )

    # Create an OntologyList object
    ontologyList <- new("OntologyList", ontologies = ontologies)

    # Verify that the slots are set correctly
    expect_equal(ontologyList@ontologies, ontologies)

    # Verify that the getOntologies method works
    expect_equal(getOntologies(ontologyList), ontologies)
})
