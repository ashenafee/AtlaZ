library(AtlaZ)

test_that("createGene creates a Gene object with the specified attributes", {
    gene <- createGene(
        geneSymbol = "ABC",
        ensemblID = "ENSG00000139618",
        zfinID = "ZFIN123"
    )

    expect_equal(gene@geneSymbol, "ABC")
    expect_equal(gene@ensemblID, "ENSG00000139618")
    expect_equal(gene@zfinID, "ZFIN123")
    expect_equal(gene@ontology, new("OntologyList", ontologies = list()))
})

test_that("setZfinID updates the ZFIN ID of a Gene object", {
    gene <- createGene(ensemblID = "ENSG00000139618")

    gene <- setZfinID(gene, "ZFIN123")

    expect_equal(gene@zfinID, "ZFIN123")
})

test_that("setOntology updates the ontology data of a Gene object", {
    gene <- createGene(ensemblID = "ENSG00000139618")

    ontology <- new("Ontology",
        id = "GO:0000001",
        name = "mitochondrion inheritance",
        definition = paste(
            "The distribution of mitochondria, including the",
            " mitochondrial genome, into daughter cells after mitosis or",
            " meiosis, mediated by interactions between mitochondria and the",
            " cytoskeleton."
        ),
        namespace = "biological_process",
        description = paste(
            "The distribution of mitochondria, including the mitochondrial",
            " genome, into daughter cells after mitosis or meiosis, mediated",
            " by interactions between mitochondria and the cytoskeleton."
        )
    )

    gene <- setOntology(gene, new("OntologyList", ontologies = list(ontology)))

    expect_equal(
        gene@ontology,
        new("OntologyList", ontologies = list(ontology))
    )
})

test_that("show prints detailed information about a Gene object", {
    gene <- createGene(
        geneSymbol = "ABC",
        ensemblID = "ENSG00000139618",
        zfinID = "ZFIN123"
    )

    expect_output(show(gene), "Gene Symbol: ABC")
    expect_output(show(gene), "Ensembl ID: ENSG00000139618")
    expect_output(show(gene), "ZFIN ID: ZFIN123")
    expect_output(show(gene), "Ontology:")
})
